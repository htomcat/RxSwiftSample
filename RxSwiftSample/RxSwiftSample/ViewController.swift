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
    let viewModel = ViewModel()

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.text.orEmpty
            .bind(to: viewModel.text)
            .disposed(by: disposeBag)
        
        viewModel.string.drive(label.rx.text).disposed(by: disposeBag)
    }
}

