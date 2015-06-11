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
        firstnamenameLabel.textColor = Constants.Colors.darkBlue;
        posLabel.textColor = Constants.Colors.darkBlue;
        sailCountryLabel.textColor = Constants.Colors.darkBlue;
        sailNumberLabel.textColor = Constants.Colors.darkBlue;
        yobLabel.textColor = Constants.Colors.darkBlue;
        clubLabel.textColor = Constants.Colors.darkBlue;
        totalPointsLabel.textColor = Constants.Colors.darkBlue;
        totalRunsLabel.textColor = UIColor.whiteColor();
        totalRunsLabel.backgroundColor = Constants.Colors.darkBlue;
        totalRunsLabel.layer.cornerRadius = 3.0;
        totalRunsLabel.layer.masksToBounds = true;

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
