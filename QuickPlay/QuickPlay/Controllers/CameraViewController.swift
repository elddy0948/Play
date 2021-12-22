//
//  CameraViewController.swift
//  QuickPlay
//
//  Created by 김호준 on 2021/12/22.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
  
  private lazy var captureButton: UIButton = {
    let button = UIButton()
    button.tintColor = .white
    button.setImage(
      UIImage(
        systemName: "circle.circle"
      ),
      for: .normal)
    return button
  }()
  
  let captureSession = AVCaptureSession()
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCaptureButton()
    layout()
    
    setupSession()
    setupPreview()
    startSession()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopSession()
  }
  
  func setupSession() {
    captureSession.beginConfiguration()
    
    guard let camera = AVCaptureDevice.default(for: .video),
          let mic = AVCaptureDevice.default(for: .audio) else {
            return
          }
    do {
      let videoInput = try AVCaptureDeviceInput(device: camera)
      let audioInput = try AVCaptureDeviceInput(device: mic)
      
      for input in [videoInput, audioInput] {
        if captureSession.canAddInput(input) {
          captureSession.addInput(input)
        }
      }
    } catch {
      print("Error setting device input: \(error)")
      return
    }
    
    captureSession.commitConfiguration()
  }
  
  
  func setupPreview() {
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = view.bounds
    previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    view.layer.addSublayer(previewLayer)
  }
  
  func startSession() {
    if !captureSession.isRunning {
      DispatchQueue.global(qos: .default).async { [weak self] in
        self?.captureSession.startRunning()
      }
    }
  }
  
  func stopSession() {
    if captureSession.isRunning {
      DispatchQueue.global(qos: .default).async { [weak self] in
        self?.captureSession.stopRunning()
      }
    }
  }
}

//MARK: - UI
extension CameraViewController {
  private func setupCaptureButton() {
    view.addSubview(captureButton)
    captureButton.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func layout() {
    NSLayoutConstraint.activate([
      captureButton.centerXAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.centerXAnchor
      ),
      captureButton.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
        constant: -16
      ),
    ])
  }
}
