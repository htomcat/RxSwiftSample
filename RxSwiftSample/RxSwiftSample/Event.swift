//
//  Event.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/12.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {
    @objc dynamic var id: Int64 = 0
    @objc dynamic var name: String = ""

    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }

    static func decode(events: [JSONObject]) -> [Event] {
        return [Event]()
    }
}
