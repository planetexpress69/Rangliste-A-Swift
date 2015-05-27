//
//  RankingListCell.swift
//  Rangliste-A-Swift
//
//  Created by Martin Kautz on 26.05.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

import UIKit

class RankingListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var yobLabel: UILabel?
    @IBOutlet weak var pointsLabel: UILabel?
    @IBOutlet weak var posLabel: UILabel?
    @IBOutlet weak var sailLabel: UILabel?
    @IBOutlet weak var clubLabel: UILabel?

    // ---------------------------------------------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel?.textColor = Constants.Colors.darkBlue
        yobLabel?.textColor = Constants.Colors.darkBlue
        pointsLabel?.textColor = Constants.Colors.darkBlue
        posLabel?.textColor = Constants.Colors.darkBlue
        sailLabel?.textColor = Constants.Colors.darkBlue
        clubLabel?.textColor = Constants.Colors.darkBlue
    }

    // ---------------------------------------------------------------------------------------------
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            nameLabel?.textColor = UIColor.whiteColor()
            yobLabel?.textColor = UIColor.whiteColor()
            pointsLabel?.textColor = UIColor.whiteColor()
            posLabel?.textColor = UIColor.whiteColor()
            sailLabel?.textColor = UIColor.whiteColor()
            clubLabel?.textColor = UIColor.whiteColor()
        } else {
            nameLabel?.textColor = Constants.Colors.darkBlue
            yobLabel?.textColor = Constants.Colors.darkBlue
            pointsLabel?.textColor = Constants.Colors.darkBlue
            posLabel?.textColor = Constants.Colors.darkBlue
            sailLabel?.textColor = Constants.Colors.darkBlue
            clubLabel?.textColor = Constants.Colors.darkBlue
        }
    }

    // ---------------------------------------------------------------------------------------------
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        if highlighted {
            nameLabel?.textColor = UIColor.whiteColor()
            yobLabel?.textColor = UIColor.whiteColor()
            pointsLabel?.textColor = UIColor.whiteColor()
            posLabel?.textColor = UIColor.whiteColor()
            sailLabel?.textColor = UIColor.whiteColor()
        } else {
            nameLabel?.textColor = Constants.Colors.darkBlue
            yobLabel?.textColor = Constants.Colors.darkBlue
            pointsLabel?.textColor = Constants.Colors.darkBlue
            posLabel?.textColor = Constants.Colors.darkBlue
            sailLabel?.textColor = Constants.Colors.darkBlue
        }
    }

}
