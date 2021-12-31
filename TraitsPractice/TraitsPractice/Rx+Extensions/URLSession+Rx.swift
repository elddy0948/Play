//
//  URLSession+Rx.swift
//  TraitsPractice
//
//  Created by 김호준 on 2021/12/31.
//

import Foundation
import RxSwift

extension Reactive where Base: URLSession {
  func response(request: URLRequest) -> Observable<URLSessionResponse> {
    return Observable.create({ observer in
      let task = URLSession.shared.dataTask(
        with: request) { data, response, error in
          if let error = error {
            observer.onError(error)
          }
          
          guard let response = response,
                let data = data else {
                  return observer.onError(error ?? RxURLSessionError.unknown)
                }
          
          guard let httpResponse = response as? HTTPURLResponse else {
            return observer.onError(RxURLSessionError.invalidResponse)
          }
          
          let urlSessionResponse = URLSessionResponse(
            response: httpResponse,
            data: data
          )
          
          observer.onNext(urlSessionResponse)
          observer.onCompleted()
        }
      
      task.resume()
      
      return Disposables.create {
        task.cancel()
      }
    })
  }
  
  private func toData(
    request: URLRequest
  ) -> Observable<Data> {
    return response(request: request)
      .map({ urlSessionResponse in
        guard 200 ..< 300 ~= urlSessionResponse.response.statusCode else {
          throw RxURLSessionError.invalidResponse
        }
        
        return urlSessionResponse.data
      })
  }
  
  func toDecodable<T: Decodable>(
    request: URLRequest,
    type: T.Type) -> Single<T> {
      return toData(request: request)
        .map({ data in
          let decoder = JSONDecoder()
          return try decoder.decode(
            T.self,
            from: data
          )
        })
        .asSingle()
    }
}
