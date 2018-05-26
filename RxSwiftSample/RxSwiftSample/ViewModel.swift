//
//  ViewModel.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/11.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

class ViewModel {
    let text = BehaviorRelay<String>(value: "")
    private let fetcher: EventsFetcher

    let account: Driver<GithubAccount.AccountStatus>
    let list: ListIdentifier
    
    // MARK: - Output
    private(set) var events: Observable<(AnyRealmCollection<Event>, RealmChangeset?)>!

    init(account: Driver<GithubAccount.AccountStatus>,
         list: ListIdentifier,
         apiType: GithubAPIProtocol.Type = GithubAPI.self) {

        self.account = account
        self.list = list

        // fetch and store
        fetcher = EventsFetcher(account: account, list: list, apiType: apiType)

    }
    private func bindOutput() {
        //bind events
        guard let realm = try? Realm() else {
            return
        }
        events = Observable.changeset(from: realm.objects(Event.self))
    }
}
