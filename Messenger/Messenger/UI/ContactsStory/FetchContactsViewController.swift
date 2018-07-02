//
//  FetchingContactsViewController.swift
//  Messenger
//
//  Created by Mohammad Allam on 6/25/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FetchContactsViewController: UIViewController, BindableType {

    // MARK: ViewModel
    var viewModel: FetchContactsViewModelType!

    // MARK: IBOutlets
    @IBOutlet weak var button_contacts: UIButton!

    // MARK: Private
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel() {

        let inputs = viewModel.inputs

        button_contacts.rx.action = inputs.addContactsAction
//        button_contacts.rx.tap.asObservable()
//            .do(onNext: {
////                inputs.getContacts()
//            })
//        .dispos
    }
}
