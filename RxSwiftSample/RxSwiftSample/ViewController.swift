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
import RxRealmDataSources

class ViewController: UIViewController {
    let bag = DisposeBag()
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
        let dataSource = RxTableViewRealmDataSource<Event>(cellIdentifier: "EventCellView", cellType: EventCellView.self) { cell, _, event in
            cell.update(with: event)
        }
        viewModel.events
            .bind(to: tableView.rx.realmChanges(dataSource))
            .disposed(by: bag)
    }
    
}

