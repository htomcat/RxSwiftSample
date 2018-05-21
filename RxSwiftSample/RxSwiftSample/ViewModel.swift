//
//  ViewModel.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/11.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    let text = BehaviorRelay<String>(value: "")

    let account: Driver<GithubAccount.AccountStatus>
    let list: ListIdentifier

    init(account: Driver<GithubAccount.AccountStatus>,
         list: ListIdentifier,
         apiType: GithubAPIProtocol.Type = GithubAPI.self) {

        self.account = account
        self.list = list

        // fetch and store

    }
}
