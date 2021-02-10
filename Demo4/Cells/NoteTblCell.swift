//
//  NoteTblCell.swift
//  Demo4
//
//  Created by PCQ196 on 09/02/21.
//

import UIKit

class NoteTblCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    var noteId : Int16?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
