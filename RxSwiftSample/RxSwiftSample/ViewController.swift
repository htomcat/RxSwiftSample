//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/09.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    private var viewModel: ViewModel!
    private let events = BehaviorRelay<[Event]>(value: [])
    private var navigator: Navigator!

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!

    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: ViewModel) -> ViewController {
        let vc = storyboard.instantiateViewController(ofType: ViewController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    func bindUI() {
    }
    
}

