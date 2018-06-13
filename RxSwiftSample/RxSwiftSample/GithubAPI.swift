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

typealias JSONObject = [String: Any]
typealias ListIdentifier = (owner: String, repo: String)

protocol GithubAPIProtocol {
    static func repository<T>(of list: ListIdentifier) -> (AccessToken) -> Single<T>
}

struct GithubAPI: GithubAPIProtocol {
    // MARK: - API Addresses
    private enum Address: String {
        case repos = "/repos"
        private var baseURL: String { return "https://api.github.com/" }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }

    // MARK: - API errors
    enum Errors: Error {
        case requestFailed
    }

    static func repository<T>(of list: ListIdentifier) -> (AccessToken) -> Single<T> {
        return { account in
            request(account, address: .repos, list: list)
        }
    }

    // MARK: - API Endpoint Requests
    static private func request<T: Any>(_ token: AccessToken, address: Address, list:ListIdentifier, parameters: [String: String] = [:]) -> Single<T> {
        return Single<T>.create { single in
            var comps = URLComponents(string: address.url.absoluteString + "/" + list.owner + "/" + list.repo)!
            comps.queryItems = parameters.map(URLQueryItem.init)
            let url = try! comps.asURL()

            let request = Alamofire.request(url.absoluteString,
                                            method: .get,
                                            parameters: Parameters(),
                                            encoding: URLEncoding.httpBody,
                                            headers: ["Authorization": "token \(token)"])
            request.responseJSON { response in
                guard
                    response.error == nil,
                    let data = response.data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? T,
                    let result = json else {

                        single(.error(Errors.requestFailed))
                        return
                }
                single(.success(result))
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
