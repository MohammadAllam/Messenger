//
//  Scene.swift
//  Messenger
//
//  Created by Mohammad Allam on 6/25/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit

enum Scene{
    case contacts(ContactsViewModel)
//    case chat
}

extension Scene{
    func viewController() -> UIViewController {
        switch self {
        case let .contacts(viewModel):
            var vc = ContactsViewController.instantiateFromNib()
            vc.bind(to: viewModel)
            return vc
//        case .chat:

        }
    }
}
