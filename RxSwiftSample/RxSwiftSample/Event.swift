//
//  Event.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/12.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import Foundation

struct Event {
    let name: String
    init(dic: [String: Any]) {
        name = dic["name"] as! String
    }
}
