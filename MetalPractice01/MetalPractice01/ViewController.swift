import Cocoa
import MetalKit

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let device = MTLCreateSystemDefaultDevice() else {
      fatalError("There is no supported GPU")
    }
    let mtkView = MTKView(frame: view.frame, device: device)
    let allocator = MTKMeshBufferAllocator(device: device)
    
    self.view = mtkView
    
    guard let monkeyURL = Bundle.main.url(forResource: "monkey", withExtension: "obj") else {
      fatalError("Coudn't find monkey.obj file!")
    }
    
    let vertexDescriptor = MTLVertexDescriptor()
    vertexDescriptor.attributes[0].format = .float3
    vertexDescriptor.attributes[0].offset = 0
    vertexDescriptor.attributes[0].bufferIndex = 0
    vertexDescriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride
    
    let meshDescriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
    (meshDescriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
    
    let asset = MDLAsset(
      url: monkeyURL,
      vertexDescriptor: meshDescriptor,
      bufferAllocator: allocator
    )
    
    let mdlMesh = asset.childObjects(of: MDLMesh.self).first as! MDLMesh
    
    guard let commandQueue = device.makeCommandQueue() else {
      fatalError("Failed to make command queue")
    }
    
//    guard let metalFileURL = Bundle.main.url(forResource: "ShaderFunc", withExtension: "metal") else {
//      fatalError("There is no ShaderFunc.metal file!")
//    }
    let shader = """
    #include <metal_stdlib>
    using namespace metal;

    struct VertexIn {
      float4 position [[attribute(0)]];
    };

    vertex float4 vertex_main(const VertexIn vertex_in [[stage_in]]) {
      return vertex_in.position;
    }

    fragment float4 fragment_main() {
      return float4(1, 0, 0, 1);
    }
    """
    
    do {
      let mesh = try MTKMesh(mesh: mdlMesh, device: device)
      let library = try device.makeLibrary(source: shader, options: nil)
      let vertexFunction = library.makeFunction(name: "vertex_main")
      let fragmentFunction = library.makeFunction(name: "fragment_main")
      
      let pipelineDescriptor = MTLRenderPipelineDescriptor()
      pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
      pipelineDescriptor.vertexFunction = vertexFunction
      pipelineDescriptor.fragmentFunction = fragmentFunction
      
      pipelineDescriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mesh.vertexDescriptor)
      
      let pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
      
      guard let commandBuffer = commandQueue.makeCommandBuffer(),
            let renderPassDescriptor = mtkView.currentRenderPassDescriptor,
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
        fatalError("Failed to create command buffer")
      }
      
      renderEncoder.setRenderPipelineState(pipelineState)
      renderEncoder.setVertexBuffer(mesh.vertexBuffers[0].buffer, offset: 0, index: 0)
      
      let submeshes = mesh.submeshes
      
      for submesh in submeshes {
        renderEncoder.drawIndexedPrimitives(
          type: .triangle,
          indexCount: submesh.indexCount,
          indexType: submesh.indexType,
          indexBuffer: submesh.indexBuffer.buffer,
          indexBufferOffset: 0
        )
      }
      
      renderEncoder.endEncoding()
      guard let drawable = mtkView.currentDrawable else {
        fatalError("Failed to get drawable")
      }
      commandBuffer.present(drawable)
      commandBuffer.commit()
    } catch {
      fatalError(error.localizedDescription)
    }
    
    
  }

  override var representedObject: Any? {
    didSet {
    }
  }
}

