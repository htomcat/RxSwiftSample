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
    convenience init(apiType: GithubAPIProtocol.Type) {
        self.init(jsonProvider: apiType.events(of: ""))
    }
    
    private init(jsonProvider: (AccessToken, String) -> Single<[String: Any]>) {
    }
}
