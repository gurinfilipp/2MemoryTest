//
//  ContactsManager.swift
//  2MemoryTest
//
//  Created by Филипп Гурин on 22.07.2021.
//

import UIKit
import Contacts

class ContactsManager {
    
    static let shared = ContactsManager()
    
    private init() {}
    
    func fetchContacts(for viewController: MainViewController) {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { access, error in
            if error != nil {
                let alertController = UIAlertController (title: "Нет доступа к контактам", message: "Разрешить доступ к контактам в настройках?", preferredStyle: .alert)
                let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    }
                }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                viewController.present(alertController, animated: true, completion: nil)
            }
            
            if access {
                let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                try? store.enumerateContacts(with: request) { contact, stopPoint in
                    viewController.contactsArray.append(contact)
                }
            } else {
                viewController.tableView.refreshControl?.beginRefreshing()
            }
        }
    }
}
