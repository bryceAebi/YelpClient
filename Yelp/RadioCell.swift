//
//  RadioCell.swift
//  Yelp
//
//  Created by Bryce Aebi on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol RadioCellDelegate {
    @objc optional func radioCell(radioCell: RadioCell, didChangeValue value: Bool)
}

class RadioCell: UITableViewCell {

    
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var radioCellLabel: UILabel!
    
    weak var delegate: RadioCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func switchValueChanged() {
        /*
        if delegate != nil {
            delegate?.switchCell?(switchCell: self, didChangeValue: onSwitch.isOn)
        }*/
    }
    
}
