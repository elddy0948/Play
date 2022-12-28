import Foundation

// I refered from AsyncCompatibilityKit
@available (iOS, deprecated: 15.0, message: "this can be used earlier than iOS 15")
extension URLSession {
  func data(from url: URL) async throws -> (Data, URLResponse) {
    return try await data(for: URLRequest(url: url))
  }
  
  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    var dataTask: URLSessionDataTask?
    let onCancel = { dataTask?.cancel() }
    
    return try await withTaskCancellationHandler(
      operation: {
        try await withCheckedThrowingContinuation({ continuation in
          dataTask = self.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response else {
              let error = error ?? URLError(.badServerResponse)
              return continuation.resume(throwing: error)
            }
            continuation.resume(returning: (data, response))
          }
          dataTask?.resume()
        })
      },
      onCancel: {
        onCancel()
      })
  }
  
  func download(from url: URL) async throws -> (URL, URLResponse) {
    return try await download(for: URLRequest(url: url))
  }
  
  func download(for request: URLRequest) async throws -> (URL, URLResponse) {
    var downloadTask: URLSessionDownloadTask?
    let onCancel = { downloadTask?.cancel() }
    
    return try await withTaskCancellationHandler(
      operation: {
        try await withCheckedThrowingContinuation({ continuation in
          downloadTask = self.downloadTask(
            with: request,
            completionHandler: { url, response, error in
              guard let url = url,
                    let response = response else {
                let error = error ?? URLError(.badServerResponse)
                return continuation.resume(throwing: error)
              }
              continuation.resume(returning: (url, response))
            })
          downloadTask?.resume()
        })
      }, onCancel: {
        onCancel()
      })
  }
}
