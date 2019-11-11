//
//  ViewControllerTema.swift
//  proyectoFinal
//
//  Created by Alumno on 11/8/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit

class ViewControllerTema: UIViewController {
    var tema = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! ViewControllerQuestionary
        view.tema = self.tema
    }

}
