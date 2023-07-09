//
//  ItemController.swift
//  Suivre Mon Poids
//
//  Created by Abdelilah on 09/07/2023.
//

import UIKit

class ItemController: UITableViewCell {

    @IBOutlet weak var text_weight: UILabel!
    @IBOutlet weak var text_date: UILabel!
    @IBOutlet weak var btn_delete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
