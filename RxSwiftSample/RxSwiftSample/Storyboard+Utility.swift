//
//  Storyboard+Utility.swift
//  RxSwiftSample
//
//  Created by htomcat on 2018/05/22.
//  Copyright © 2018年 htomcat. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
