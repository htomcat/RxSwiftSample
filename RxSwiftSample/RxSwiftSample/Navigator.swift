//
//  Navigator.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/21.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import Foundation
import RxCocoa

class Navigator {
    enum Segue {
        case listEvents(Driver<GithubAccount.AccountStatus>, ListIdentifier)
    }
    
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .listEvents(let account, let list):
            break
        }
    }
}
