//
//  ContactsViewModel.swift
//  Messenger
//
//  Created by Mohammad Allam on 6/25/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation
import RxSwift
import Action
import Contacts

protocol ContactsViewModelInput {

//    var showCuratedPhotosAction: CocoaAction { get }
    var addContactsAction: CocoaAction { get }
}

protocol ContactsViewModelOutput {

    /// Emits an error string once an exception happens
    var errorString: Observable<String>! { mutating get }
}

protocol ContactsViewModelType {
    var inputs: ContactsViewModelInput { get }
    var outputs: ContactsViewModelOutput { get }
    //    func createHomeViewCellModel(for photo: Photo) -> ContactsViewCellModel
}

class ContactsViewModel: ContactsViewModelType,
    ContactsViewModelInput,
ContactsViewModelOutput{

    // MARK: Inputs & Outputs
    var inputs: ContactsViewModelInput { return self }
    var outputs: ContactsViewModelOutput { return self }

    // MARK: Input
    lazy var addContactsAction: CocoaAction = {
        CocoaAction{ [unowned self] in

            var contacts = [CNContact]()
            let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
            let request = CNContactFetchRequest(keysToFetch: keys)

            do {
                try self.contactStore.enumerateContacts(with: request) {
                    (contact, stop) in
                    // Array containing all unified contacts from everywhere
                    contacts.append(contact)
                }
            }
            catch {
                self.errorStringProperty.onNext("unable to fetch contacts")
            }
            return .empty()
        }
    }()

    // MARK: Output
    var errorString: Observable<String>!{
        return errorStringProperty.asObservable()
    }

    // MARK: Private
    private let contactStore = CNContactStore()
    private let errorStringProperty = BehaviorSubject<String>(value: "")


    // MARK: Init
    init() {
        
    }


}
