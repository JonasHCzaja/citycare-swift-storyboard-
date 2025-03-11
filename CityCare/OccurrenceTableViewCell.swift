//
//  OccurrenceTableViewCell.swift
//  CityCare
//
//  Created by Jonas Czaja on 02/09/24.
//

import UIKit

class OccurrenceTableViewCell: UITableViewCell {

    @IBOutlet weak var lbIssue: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
