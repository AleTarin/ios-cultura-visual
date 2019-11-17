//
//  TableViewCellEstad.swift
//  proyectoFinal
//
//  Created by Layla Tame on 11/16/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit

class TableViewCellEstad: UITableViewCell {

    var tema = [String:Any]()
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var pvProgreso: UIProgressView!
    @IBOutlet weak var igImage: UIImageView!
    @IBOutlet weak var lbCorrect: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
