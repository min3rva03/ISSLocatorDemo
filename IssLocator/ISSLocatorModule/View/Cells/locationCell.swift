//
//  locationCell.swift
//  IssLocator
//
//  Created by Minerva Nolasco Espino on 13/05/22.
//

import UIKit

class locationCell: UITableViewCell {
    
    @IBOutlet weak var latitudLbl: UILabel!
    @IBOutlet weak var longitudLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
