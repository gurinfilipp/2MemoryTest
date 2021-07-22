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
        return label
    }()
    
    private let phoneLabel: UILabel = {
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
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
        nameLabel.pin.left(15).top(8).height(25).width(200)
        phoneLabel.pin.below(of: nameLabel).marginTop(8).left(15).height(30).horizontally(15)
    }
    
    func configure(with contact: CNContact) {
        nameLabel.text = contact.givenName
        guard let phoneNumber = contact.phoneNumbers.first else {
            phoneLabel.text = "Номер телефона отсутствует"
            return
        }
        phoneLabel.text = phoneNumber.value.stringValue
    }
}
