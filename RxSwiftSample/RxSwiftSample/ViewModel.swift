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
    let string: Driver<String>

    init() {
        string = text.map { charactor in
            return charactor
        }
        .asDriver(onErrorJustReturn: "")
    }
}
