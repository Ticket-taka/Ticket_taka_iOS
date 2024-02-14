//
//  NetworkService.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation
import Alamofire
import RxSwift

protocol NetworkService {
    func response<D: Decodable>(_ urlRequestConvertible: URLRequestConvertible,
                              type: D.Type) -> Single<D>
    
    func response(_ urlRequestConvertible: URLRequestConvertible) -> Single<Data>
}

extension NetworkService {
    func response<D: Decodable>(_ urlRequestConvertible: URLRequestConvertible,
                              type: D.Type) -> Single<D> {
        guard let urlRequest = try? urlRequestConvertible.asURLRequest() else {
            return Single<D>.error(NetworkError.badRequestError)
        }
        URLCache.shared.removeCachedResponse(for: urlRequest)
        return Single.create { single in
            AF.request(urlRequest)
                .responseDecodable(of: NetworkResponseWrapper<D>.self) { response in
                    do {
                        if let statusCode =  response.response?.statusCode {
                            switch statusCode {
                            case (200..<400): break
                            case (400): throw NetworkError.badRequestError
                            case (404): throw NetworkError.notFoundError
                            case (403): throw NetworkError.forbiddenError
                            case (500): throw NetworkError.internalServerError
                            default: break
                            }
                        }
                        guard let networkResult = response.value else {
                            throw response.error ?? NetworkError.notFoundError
                        }
                        
                        print(networkResult)
                        
                        guard let result = networkResult.result else {
                            throw NetworkError.notFoundError
                        }
                        
                        single(.success(result))
                    } catch {
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
    
    func response(_ urlRequestConvertible: URLRequestConvertible) -> Single<Data> {
        Single.create { single in
            AF.request(urlRequestConvertible)
                .responseData { response in
                    do {
                        if let error = response.error { throw error}
                        guard let value = response.value else { throw NetworkError.notFoundError }
                        single(.success(value))
                    } catch {
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
