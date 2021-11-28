import UIKit
import RxSwift

public var internalCache = [String: Data]()

extension Reactive where Base: URLSession {
  func response(request: URLRequest) -> Observable<(HTTPURLResponse, Data)> {
    return Observable.create({ observer in
      let task = self.base.dataTask(with: request) { data, response, error in
        guard let response = response,
              let data = data else {
                return observer.onError(error ?? RxURLSessionError.unknown)
              }
        guard let httpResponse = response as? HTTPURLResponse else {
          return observer.onError(RxURLSessionError.invalidResponse)
        }
        
        observer.onNext((httpResponse, data))
        observer.onCompleted()
      }
      task.resume()
      return Disposables.create { task.cancel() }
    })
  }
  
  func data(request: URLRequest) -> Observable<Data> {
    return response(request: request)
      .cache()
      .map({ httpResponse, data in
        guard 200..<300 ~= httpResponse.statusCode else {
          throw RxURLSessionError.requestFailed
        }
        return data
      })
  }
  
  func decodable<D: Decodable>(request: URLRequest, type: D.Type) -> Observable<D> {
    return data(request: request).map({ data in
      let decoder = JSONDecoder()
      return try decoder.decode(D.self, from: data)
    })
  }
  
  func image(request: URLRequest) -> Observable<UIImage> {
    return data(request: request).map({ data in
      return UIImage(data: data) ?? UIImage()
    })
  }
}

extension ObservableType where Element == (HTTPURLResponse, Data) {
  func cache() -> Observable<Element> {
    return self.do(onNext: { response, data in
      guard let url = response.url?.absoluteString,
            200 ..< 300 ~= response.statusCode else {
              return
            }
      internalCache[url] = data
    })
  }
}
