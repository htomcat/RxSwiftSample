//
//  Event.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/12.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Event: Object, Mappable {
    @objc dynamic var id: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var time: String = ""

    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        time <- map["time"]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }

    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }

    static func transform(json: JSONObject) -> Event {
        return Event(JSON: json)!
    }
}
