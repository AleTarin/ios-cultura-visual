
//
//  ViewControllerEstadisticas.swift
//  proyectoFinal
//
//  Created by Alumno on 10/24/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit
import UICircularProgressRing

class ViewControllerEstadisticas: UIViewController {

    @IBOutlet weak var otProgress: UICircularProgressRing!
    var tareas: [[String:Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usuarioTemaService.getData(user: userService.email, completionHandler: { temas in
            self.tareas = temas
        })
        
        otProgress.style = .ontop
        otProgress.backgroundColor = self.view.backgroundColor
        otProgress.maxValue = 100
        otProgress.outerRingColor = .gray
        otProgress.innerRingColor = .yellow
        otProgress.outerRingWidth = 20
        otProgress.innerRingWidth = 13
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        otProgress.startProgress(to: 68, duration: 4.0)

    }
    
    @IBAction func btHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
