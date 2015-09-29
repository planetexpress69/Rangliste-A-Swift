//
//  SailorCell.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 11.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class SailorCell: UITableViewCell {

    @IBOutlet weak var firstnamenameLabel: UILabel!
    @IBOutlet weak var posLabel: UILabel!
    @IBOutlet weak var sailCountryLabel: UILabel!
    @IBOutlet weak var sailNumberLabel: UILabel!
    @IBOutlet weak var yobLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var totalRunsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstnamenameLabel.textColor = Constants.Colors.textColor
        posLabel.textColor = Constants.Colors.textColor
        sailCountryLabel.textColor = Constants.Colors.textColor
        sailNumberLabel.textColor = Constants.Colors.textColor
        yobLabel.textColor = Constants.Colors.textColor
        clubLabel.textColor = Constants.Colors.textColor
        totalPointsLabel.textColor = Constants.Colors.textColor
        totalRunsLabel.textColor = .whiteColor()
        totalRunsLabel.backgroundColor = Constants.Colors.textColor
        totalRunsLabel.layer.cornerRadius = 3.0
        totalRunsLabel.layer.masksToBounds = true

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
