//
//  SceneCoordinatorType.swift
//  Messenger
//
//  Created by Mohammad Allam on 6/25/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {

    init(window: UIWindow)

    @discardableResult func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void>
    @discardableResult func pop(animated: Bool) -> Observable<Void>
}
