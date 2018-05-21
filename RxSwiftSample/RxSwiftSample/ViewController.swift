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

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func fetchEvents(repo: String) {
        let reponse = Observable.of(repo)
            .map { urlString -> URL in
                return URL(string: "https://api.github.com/repos/\(urlString)/events")!
            }
            .map { url -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { request in
                return URLSession.shared.rx.response(request: request)
            }
            .share(replay: 1, scope: .whileConnected)

        reponse
            .filter { reponse, _ in
                return 200...300 ~= reponse.statusCode
            }
            .map { _, data -> [[String: Any]] in
                guard
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let result = jsonObject as? [[String: Any]] else {
                        return []
                }
                return result
            }
            .filter { object in
                return object.count > 0
            }
            .map { object in
                return object.compactMap(Event.init)
            }
            .subscribe(onNext: { [weak self] newEvents in
                self?.events.accept(newEvents)
            })
            .disposed(by: disposeBag)
    }
}

