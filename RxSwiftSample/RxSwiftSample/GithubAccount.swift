//
//  GithubAccount.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/20.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

typealias AccessToken = String

struct GithubAccount {
    
    static private var key: String!
    static private var secret: String!
    static func set(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }

    // logged or not
    enum AccountStatus {
        case unavailable
        case authorized(AccessToken)
    }

    var `default`: Driver<AccountStatus> {
        return Observable.create { observal in
            if let storedToken = UserDefaults.standard.string(forKey: "token") {
                observal.onNext(.authorized(storedToken))
            }
            return Disposables.create {
            }
        }.asDriver(onErrorJustReturn: .unavailable)
    }
}
