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
        regattaNameLabel?.textColor     = .whiteColor()
        regattaFactorLabel?.textColor   = .whiteColor()
        pointsLabel?.textColor          = .whiteColor()
        positionLabel?.textColor        = .whiteColor()
        self.backgroundColor = Constants.Colors.textColor
    }

    // ---------------------------------------------------------------------------------------------
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            regattaNameLabel?.textColor = Constants.Colors.textColor
            regattaFactorLabel?.textColor = Constants.Colors.textColor
            pointsLabel?.textColor = Constants.Colors.textColor
            positionLabel?.textColor = Constants.Colors.textColor
            self.backgroundColor = .whiteColor()
        } else {
            regattaNameLabel?.textColor = .whiteColor()
            regattaFactorLabel?.textColor = .whiteColor()
            pointsLabel?.textColor = .whiteColor()
            positionLabel?.textColor = .whiteColor()
            self.backgroundColor = Constants.Colors.textColor
        }
    }

    // ---------------------------------------------------------------------------------------------
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            regattaNameLabel?.textColor = Constants.Colors.textColor
            regattaFactorLabel?.textColor = Constants.Colors.textColor
            pointsLabel?.textColor = Constants.Colors.textColor
            positionLabel?.textColor = Constants.Colors.textColor
            self.backgroundColor = .whiteColor()
        } else {
            regattaNameLabel?.textColor = .whiteColor()
            regattaFactorLabel?.textColor = .whiteColor()
            pointsLabel?.textColor = .whiteColor()
            positionLabel?.textColor = .whiteColor()
            self.backgroundColor = Constants.Colors.textColor
        }
    }

}
