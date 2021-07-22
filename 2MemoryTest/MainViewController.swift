//
//  MainViewController.swift
//  2MemoryTest
//
//  Created by Филипп Гурин on 22.07.2021.
//

import UIKit
import PinLayout
import Contacts

class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }()
    
    private var contactsArray: [CNContact] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        title = "Контакты"
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        
        fetchContacts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
    }
    
    private func fetchContacts() {
        print("fetching")
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { access, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if access {
                print("we have acess")
                
                let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                try? store.enumerateContacts(with: request) { contact, stopPoint in
                    self.contactsArray.append(contact)
                    
                }
            } else {
                print("we dont have acess")
            }
            
        }
        
    }
    
    @objc private func didPullRefresh() {
        contactsArray = []
        fetchContacts()
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return .init()
        }
    
        
        cell.configure(with: contactsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
    
}
