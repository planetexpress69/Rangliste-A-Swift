//
//  RegattaListCell.swift
//  Rang
//
//  Created by Martin Kautz on 19.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RegattaListCell: UITableViewCell {

    @IBOutlet weak var regattaNameLabel: UILabel?
    @IBOutlet weak var regattaFactorLabel: UILabel?
    @IBOutlet weak var pointsLabel: UILabel?
    @IBOutlet weak var positionLabel: UILabel?

    // ---------------------------------------------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        regattaNameLabel?.textColor = Constants.Colors.darkBlue
        regattaFactorLabel?.textColor = Constants.Colors.darkBlue
        pointsLabel?.textColor = Constants.Colors.darkBlue
        positionLabel?.textColor = Constants.Colors.darkBlue
    }

    // ---------------------------------------------------------------------------------------------
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            regattaNameLabel?.textColor = UIColor.whiteColor()
            regattaFactorLabel?.textColor = UIColor.whiteColor()
            pointsLabel?.textColor = UIColor.whiteColor()
            positionLabel?.textColor = UIColor.whiteColor()
        } else {
            regattaNameLabel?.textColor = Constants.Colors.darkBlue
            regattaFactorLabel?.textColor = Constants.Colors.darkBlue
            pointsLabel?.textColor = Constants.Colors.darkBlue
            positionLabel?.textColor = Constants.Colors.darkBlue
        }
    }

    // ---------------------------------------------------------------------------------------------
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            regattaNameLabel?.textColor = UIColor.whiteColor()
            regattaFactorLabel?.textColor = UIColor.whiteColor()
            pointsLabel?.textColor = UIColor.whiteColor()
            positionLabel?.textColor = UIColor.whiteColor()
        } else {
            regattaNameLabel?.textColor = Constants.Colors.darkBlue
            regattaFactorLabel?.textColor = Constants.Colors.darkBlue
            pointsLabel?.textColor = Constants.Colors.darkBlue
            positionLabel?.textColor = Constants.Colors.darkBlue
        } 
    }
}
