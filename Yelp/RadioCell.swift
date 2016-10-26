//
//  RadioCell.swift
//  Yelp
//
//  Created by Bryce Aebi on 10/23/16.
//

import UIKit

@objc protocol RadioCellDelegate {
    @objc optional func radioCell(radioCell: RadioCell, didChangeValue value: Bool)
}

class RadioCell: UITableViewCell {

    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var radioCellLabel: UILabel!
    
    weak var delegate: RadioCellDelegate?
}
