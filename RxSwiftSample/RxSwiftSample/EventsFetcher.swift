//
//  EventsFetcher.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/17.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EventsFetcher {
    convenience init(account: Driver<GithubAccount.AccountStatus>, list: ListIdentifier, apiType: GithubAPIProtocol.Type) {
        self.init(account: account, jsonProvider: apiType.events(of: ""))
    }
    convenience init(account: Driver<GithubAccount.AccountStatus>, repositoryName: String, apiType: GithubAPIProtocol.Type) {
        self.init(account: account, jsonProvider: apiType.events(of: repositoryName))
    }
    
    private init(account: Driver<GithubAccount.AccountStatus>, jsonProvider: (AccessToken) -> Single<[String: Any]>) {
        let currentAccount: Observable<AccessToken> = account
            .filter { account in
                switch account {
                case .authorized: return true
                default: return false
                }
            }
            .map { account -> AccessToken in
                switch account {
                case .authorized(let acaccount):
                    return acaccount
                default: fatalError()
                }
                
            }
            .asObservable()
    }
}
