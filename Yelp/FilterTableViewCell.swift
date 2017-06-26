//
//  FilterTableViewCell.swift
//  Yelp
//
//  Created by TK Nguyen on 6/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit



@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: FilterTableViewCell, didChangeValue value: Bool)
}

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.onSwitch.addTarget(self, action: #selector(self.switchValueChanged), for: UIControlEvents.valueChanged)
        
        
    }
    
    func switchValueChanged(){
        delegate?.switchCell?(switchCell: self, didChangeValue: onSwitch.isOn)
        print("changed in cell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
