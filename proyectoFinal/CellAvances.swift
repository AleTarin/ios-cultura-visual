//
//  CellAvances.swift
//  proyectoFinal
//
//  Created by Layla Tame on 11/17/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit

class CellAvances: UITableViewCell {

    @IBOutlet weak var ivImagen: UIImageView!
    @IBOutlet weak var lbTema: UILabel!
    @IBOutlet weak var pvProgress: UIProgressView!
    @IBOutlet weak var lbCorrectas: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }

}
