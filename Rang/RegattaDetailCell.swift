//
//  RegattaDetailCell.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 11.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RegattaDetailCell: UITableViewCell {

    @IBOutlet weak var rnameLabel: UILabel!;
    @IBOutlet weak var sl_pointsLabel: UILabel!;
    @IBOutlet weak var  sl_points_cupLabel: UILabel!;
    @IBOutlet weak var  positionboatsLabel: UILabel!;
    @IBOutlet weak var  runs_totalLabel: UILabel!;
    @IBOutlet weak var  runs_scoredLabel: UILabel!;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        rnameLabel.textColor = Constants.Colors.darkBlue;
        sl_points_cupLabel.textColor = Constants.Colors.darkBlue;
        sl_pointsLabel.textColor = Constants.Colors.darkBlue;
        positionboatsLabel.textColor = Constants.Colors.darkBlue;
        runs_totalLabel.textColor = Constants.Colors.darkBlue
        runs_scoredLabel.textColor = UIColor.whiteColor()
        runs_scoredLabel.backgroundColor = Constants.Colors.darkBlue;
        runs_scoredLabel.layer.cornerRadius = 3.0;
        runs_scoredLabel.layer.masksToBounds = true;
    }

}
