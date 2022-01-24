import Foundation
import RxSwift

extension Reactive where Base: URLSession {
  func dataTask(request: URLRequest) -> Observable<(HTTPURLResponse, Data)> {
    return Observable.create({ observer in
      let task = base.dataTask(
        with: request,
        completionHandler: { (data, response, error) in
          if let _ = error {
            return observer.onError(NetworkError.invalidRequest)
          }
          
          guard let response = response,
                let httpResponse = response as? HTTPURLResponse else {
                  return observer.onError(NetworkError.invalidRequest)
                }
          guard let data = data else {
            return observer.onError(NetworkError.invalidRequest)
          }
          
          observer.onNext((httpResponse, data))
          observer.onCompleted()
        }
      )
      
      task.resume()
      
      return Disposables.create{ task.cancel() }
    })
  }
  
  func toData(request: URLRequest) -> Observable<Data> {
    return dataTask(request: request)
      .map({ (response, data) in
        guard (200 ..< 300) ~= response.statusCode else {
          throw NetworkError.invalidData
        }
        return data
      })
  }
  
  func toDecodable<T: Decodable>(
    request: URLRequest,
    type: T.Type
  ) -> Observable<T> {
    return toData(request: request)
      .map({ data in
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
      })
  }
}
