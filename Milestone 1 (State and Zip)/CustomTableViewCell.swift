//
//  CustomTableViewCell.swift
//  Milestone 1 (State and Zip)
//
//  Created by Yogesh Tekwani on 5/13/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static var identifier = "CustomTableViewCell"
    
    var stateLabel: UILabel = {
        let sLabel = UILabel()
        sLabel.textColor = .systemBlue
        sLabel.translatesAutoresizingMaskIntoConstraints = false
        return sLabel
    }()
    
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(stateLabel)
        
        
        
        NSLayoutConstraint.activate(
            [stateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
             stateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
             stateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
             stateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
