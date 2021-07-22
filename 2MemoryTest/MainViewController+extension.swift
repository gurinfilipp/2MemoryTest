//
//  MainViewController+extension.swift
//  2MemoryTest
//
//  Created by Филипп Гурин on 22.07.2021.
//

import UIKit

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let callNumber = contactsArray[indexPath.row].phoneNumbers.first?.value.stringValue else {
            return
        }
        let symbolsToDelete = ["+", " ", "-", "(", ")"]
        var callNumberFormatted = callNumber
        for symbol in 0...symbolsToDelete.count - 1 {
            callNumberFormatted = callNumberFormatted.replacingOccurrences(of: symbolsToDelete[symbol], with: "")
        }
        if let url = URL(string: "tel://\(callNumberFormatted)") {
        UIApplication.shared.open(url)
    }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
