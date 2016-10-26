//
//  SwitchCell.swift
//  Yelp
//
//  Created by Bryce Aebi on 10/22/16.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func switchValueChanged() {
        if delegate != nil {
            delegate?.switchCell?(switchCell: self, didChangeValue: onSwitch.isOn)
        }
    }
}
