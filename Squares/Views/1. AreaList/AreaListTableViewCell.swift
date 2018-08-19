//
//  AreaListTableViewCell.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 14/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class AreaListTableViewCell: UITableViewCell {
    
    var viewModel: AreaListCellViewModelType? {
        willSet(newValue) {
            areaName.text = newValue?.getAreaName()
            areaCreationDate.text = newValue?.getAreaCreationDate()
        }
    }

    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var areaCreationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
