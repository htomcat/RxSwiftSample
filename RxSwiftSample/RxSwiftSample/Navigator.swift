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
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    enum Segue {
        case listEvents(Driver<GithubAccount.AccountStatus>, ListIdentifier)
    }
    
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .listEvents(let account, let list):
            let vm = ViewModel(account: account, list: list)
            let target = ViewController.createWith(navigator: self, storyboard: sender.storyboard ?? defaultStoryboard, viewModel: vm)
            show(target: target, sender: sender)
        }
    }

    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: false)
        }
        
        if let nav = sender.navigationController {
            nav.pushViewController(target, animated: true)
        } else {
            sender.present(target, animated: true, completion: nil)
        }
    }
}
