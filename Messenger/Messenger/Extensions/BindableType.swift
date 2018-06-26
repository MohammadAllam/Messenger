//
//  BindableType.swift
//  Messenger
//
//  Created by Mohammad Allam on 6/25/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit

protocol BindableType {
    associatedtype ViewModelType

    var viewModel: ViewModelType { get set }
    func bindViewModel()
}

extension BindableType where Self: UIViewController {

    mutating func bind(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
