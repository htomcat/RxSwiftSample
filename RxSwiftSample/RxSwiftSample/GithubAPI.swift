//
//  GithubAPI.swift
//  RxSwiftSample
//
//  Created by 浜田　智史 on 2018/05/15.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

protocol GithubAPIProtocol {
    static func events(of repository: String) -> Observable<[String: Any]>
}

struct GithubAPI: GithubAPIProtocol {
    private enum Address: String {
        case events = "/events"
        private var baseURL: String { return "https://api.github.com/repos/" }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }


    /*
    static func events(of repository: String) -> Observable<[String : Any]> {
    }
 */
    static private func request<T: Any>(_ token: String, address: Address, parameters: [String: String] = [:]) -> Single<T> {
        return Single.create { single in
            var comps = URLComponents(string: address.url.absoluteString)!
            comps.queryItems = parameters.map(URLQueryItem.init)
            let url = try! comps.asURL()

            let request = Alamofire.request(url.absoluteString,
                                            method: .get,
                                            parameters: Parameters(),
                                            encoding: URLEncoding.httpBody,
                                            headers: ["Authorization": "Bearer \(token)"])
            request.responseJSON { response in
                guard
                    response.error == nil,
                    let data = response.data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? T,
                    let result = json else {
                        
                        return
                }
            }

            return Disposables.create {
            }
        }
    }
}
