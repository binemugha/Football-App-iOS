//
//  DateTableViewCell.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import UIKit

enum DateFormatType: String {
    case date = "dd-MMM-yyyy"
}

class DateTableViewCell: UITableViewCell {
    
    let labelDescription = UILabel()
    let dateLabel = UILabel()
    
    static let reuseIdentifier = "DateTableViewCellIdentifier"
    static let cellHeight: CGFloat = 44.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabels() {
        for label in [labelDescription, dateLabel] {
            contentView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
        
        labelDescription.textAlignment = .left
        dateLabel.textAlignment = .right
    }
    
    func updateText(text: String, date: Date) {
        labelDescription.text = text
        dateLabel.text = date.convertToString(dateformat: .date)
    }

}

extension Date {
    
    func convertToString(dateformat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
}

