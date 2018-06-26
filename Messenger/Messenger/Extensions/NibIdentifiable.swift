//
//  NibIdentifiable.swift
//  Messenger
//
//  Created by Mohammad Allam on 6/25/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit

protocol NibIdentifiable {

    static var nibIdentifier: String { get }
}

extension UIViewController: NibIdentifiable {

    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension NibIdentifiable where Self:UIViewController {

    static func instantiateFromNib() -> Self {
        return Self(nibName: nibIdentifier,
                    bundle: nil)
    }
}
