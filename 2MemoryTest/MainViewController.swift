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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }()
    
    var contactsArray: [CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "Контакты"
        
        tableViewSetup()
        ContactsManager.shared.fetchContacts(for: self)
    }
    
    private func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    @objc private func didPullRefresh() {
        contactsArray = []
        ContactsManager.shared.fetchContacts(for: self)
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
}
