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
import RealmSwift
import RxRealm

protocol FetchContactsViewModelInput {

    //    var showCuratedPhotosAction: CocoaAction { get }
    var addContactsAction: CocoaAction { get }
}

protocol FetchContactsViewModelOutput {

    /// Emits an error string once an exception happens
    var errorString: Observable<String>! { mutating get }
}

protocol FetchContactsViewModelType {
    var inputs: FetchContactsViewModelInput { get }
    var outputs: FetchContactsViewModelOutput { get }
    //    func createHomeViewCellModel(for photo: Photo) -> ContactsViewCellModel
}

class FetchContactsViewModel: FetchContactsViewModelType,
    FetchContactsViewModelInput,
FetchContactsViewModelOutput{

    // MARK: Inputs & Outputs
    var inputs: FetchContactsViewModelInput { return self }
    var outputs: FetchContactsViewModelOutput { return self }

    // MARK: Input
    lazy var addContactsAction: CocoaAction = {
        CocoaAction{ [unowned self] in

            self.fetchAllContacts()
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
    private lazy var realm = try! Realm()

    private func fetchAllContacts(){

        let contacts = List<Contact>()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        let request = CNContactFetchRequest(keysToFetch: keys)

        do {
            try self.contactStore.enumerateContacts(with: request) {
                (contact:CNContact, stop) in
                // Array containing all unified contacts from everywhere
                let phones = List<String>()
                // Checking if phone number is available for the given contact.
                if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {

                    contact.phoneNumbers.forEach { (numberLabel:CNLabeledValue<CNPhoneNumber>) in
                        phones.append(numberLabel.value.stringValue)
                    }
                }else{
                    //Refetch the keys
                    do{
                        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
                        let newlyFetchedContact = try self.contactStore.unifiedContact(withIdentifier: contact.identifier,
                                                                                       keysToFetch: keysToFetch )

                        newlyFetchedContact.phoneNumbers.forEach { (numberLabel:CNLabeledValue<CNPhoneNumber>) in
                            phones.append(numberLabel.value.stringValue)
                        }
                    }catch {
                        self.errorStringProperty.onNext("unable to fetch contacts")
                    }
                    //                        print("\(refetchedContact.phoneNumbers)")
                }

                contacts.append(Contact(name: contact.givenName,
                                        numbers: phones))

            }

            try self.realm.write {
                self.realm.add(contacts)
                self.moveToContactsVC()
            }
        }
        catch  let error as NSError {
            // If the encryption key is wrong, `error` will say that it's an invalid database
            //                fatalError("Error opening realm: \(error)")

            self.errorStringProperty.onNext("Error opening realm: \(error)")
        }
    }

    private func moveToContactsVC(){

//        let viewModel = PhotoDetailsViewModel(photo: photo)
//        return self.sceneCoordinator.transition(to: .photoDetails(viewModel), type: .modal)
    }


    // MARK: Init
    init() {
        
    }


}
