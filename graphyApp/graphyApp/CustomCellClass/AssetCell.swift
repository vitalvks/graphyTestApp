//
//  AssetCell.swift
//  graphyApp
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit
import SDWebImage

class AssetCell: UITableViewCell {
    
    @IBOutlet weak var assetImg: UIImageView!
    @IBOutlet weak var assetTitle: UILabel!
    @IBOutlet weak var assetDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUsingModel(model: AssetInfoModel) {
        self.assetTitle.text = model.assetTitle
        self.assetDescription.text = model.assetDescription
        self.assetImg.sd_setImage(with: URL(string: model.assetImageUrl ?? ""), placeholderImage: UIImage(named: "placeHolder.png"))
    }

}
