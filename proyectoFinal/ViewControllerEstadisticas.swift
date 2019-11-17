
//
//  ViewControllerEstadisticas.swift
//  proyectoFinal
//
//  Created by Alumno on 10/24/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit
import UICircularProgressRing
import FirebaseCore
import FirebaseFirestore

class ViewControllerEstadisticas: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var otProgress: UICircularProgressRing!
    @IBOutlet weak var tvTareas: UITableView!
    var temas: [[String:Any]] = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tvTareas.delegate = self
        tvTareas.dataSource = self
        
        usuarioTemaService.getData(user: userService.email, completionHandler: { temas in
            self.temas = temas
            print (self.temas)

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
        otProgress.startProgress(to: 75, duration: 4.0)
        loadData()

    }
    
    func loadData(){
        // Get Data from firebase
        usuarioTemaService.getData(user: userService.email, completionHandler: { temas in
            self.temas = temas
            self.tvTareas.reloadData()
        })
    }
    
    @IBAction func btHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.temas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tarea", for: indexPath) as! TableViewCellEstad
        /*
        let tema = self.temas[indexPath.row]
        let corrects = tema["correct_answers"] as! Float
        let incorrects = tema["wrong_answers"] as! Float
        
        var progress: Float = 0
        let total = corrects + incorrects
        if total != 0 {
            progress =  corrects / total
        }
        
        cell.lbCorrect.text = String(corrects)
        cell.lbTotal.text = String(total)
        
        cell.lbContent?.text = tema["topic_name"] as? String
        if tema["topic_hasImage"] as! Bool {
            let url =  URL(string: tema["topic_image"] as! String )
            cell.igImage.load(url: url!)
        }
        
        cell.pvProgreso.setProgress(progress, animated: true)
        cell.tema = tema
 */
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }*/
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? TableViewCellTarea {
            let view = segue.destination as! ViewControllerTema
            view.tema = cell.tema
        }
        
    }*/


}

