//
//  ContactCell.swift
//  2MemoryTest
//
//  Created by Филипп Гурин on 22.07.2021.
//

import Foundation
import UIKit
import Contacts
import PinLayout

final class ContactCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.backgroundColor = .red
        return label
    }()
    
    private let phoneLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.backgroundColor = .green
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.pin.left(15).top(15).height(50).width(200)
        phoneLabel.pin.below(of: nameLabel).marginTop(15).left(15).height(50).horizontally(15)
    }
    
    func configure(with contact: CNContact) {
        nameLabel.text = contact.givenName
        guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else {
            phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
            phoneLabel.text = "У данного контакта отсутствует номер телефона"
            return
        }
        phoneLabel.text = phoneNumber
    }
    
}
