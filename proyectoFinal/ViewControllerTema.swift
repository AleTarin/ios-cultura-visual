//
//  ViewControllerTema.swift
//  proyectoFinal
//
//  Created by Alumno on 11/8/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit

class ViewControllerTema: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var rankingTable: UITableView!
    @IBOutlet weak var lbTema: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    // Array de preguntas
     // Cada pregunta es un dictionary
     var temas: [[String:Any]] = []
     
     override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
     }

     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell", for: indexPath)
         let tema = self.temas[indexPath.row]
         let score = tema["score"] as! Int
         let user  = tema["user"]  as! String
         cell.textLabel?.text = String(score)
         cell.detailTextLabel?.text = user
         return cell
     }
     
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.temas.count
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

    var tema = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTema.text = (tema["topic_name"] as! String)
        if tema["topic_hasImage"] as! Bool {
            let url =  URL(string: tema["topic_image"] as! String )
            ivImage.load(url: url!)
        }
        rankingTable.delegate = self
        rankingTable.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        usuarioTemaService.getRanking(topic_id: tema["topic_id"] as! String) { temas in
            self.temas = temas
            self.rankingTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultados" {
            let viewResultados = segue.destination as! ViewControllerResultados
            //do magic with your destination
            viewResultados.tema = self.tema
            viewResultados.viewControl = "resultados"
        }
        else {
            let view = segue.destination as! ViewControllerQuestionary
            view.tema = self.tema
            view.viewControl = "cuestionario"
        }
    }

}
