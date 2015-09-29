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
        nameLabel?.textColor = Constants.Colors.textColor
        yobLabel?.textColor = Constants.Colors.textColor
        pointsLabel?.textColor = Constants.Colors.textColor
        posLabel?.textColor = Constants.Colors.textColor
        sailLabel?.textColor = Constants.Colors.textColor
        clubLabel?.textColor = Constants.Colors.textColor
    }

    // ---------------------------------------------------------------------------------------------
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            nameLabel?.textColor = .whiteColor()
            yobLabel?.textColor = .whiteColor()
            pointsLabel?.textColor = .whiteColor()
            posLabel?.textColor = .whiteColor()
            sailLabel?.textColor = .whiteColor()
            clubLabel?.textColor = .whiteColor()
        } else {
            nameLabel?.textColor = Constants.Colors.textColor
            yobLabel?.textColor = Constants.Colors.textColor
            pointsLabel?.textColor = Constants.Colors.textColor
            posLabel?.textColor = Constants.Colors.textColor
            sailLabel?.textColor = Constants.Colors.textColor
            clubLabel?.textColor = Constants.Colors.textColor
        }
    }

    // ---------------------------------------------------------------------------------------------
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        if highlighted {
            nameLabel?.textColor = .whiteColor()
            yobLabel?.textColor = .whiteColor()
            pointsLabel?.textColor = .whiteColor()
            posLabel?.textColor = .whiteColor()
            sailLabel?.textColor = .whiteColor()
            clubLabel?.textColor = .whiteColor()

        } else {
            nameLabel?.textColor = Constants.Colors.textColor
            yobLabel?.textColor = Constants.Colors.textColor
            pointsLabel?.textColor = Constants.Colors.textColor
            posLabel?.textColor = Constants.Colors.textColor
            sailLabel?.textColor = Constants.Colors.textColor
            clubLabel?.textColor = Constants.Colors.textColor
        }
    }
}
