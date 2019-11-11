//
//  ViewControllerIndice.swift
//  proyectoFinal
//
//  Created by user916803 on 10/12/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewControllerIndice: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvIndice: UITableView!
    
    // Array de preguntas
    // Cada pregunta es un dictionary
    var temas: [[String:Any]] = []
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvIndice.delegate = self
        tvIndice.dataSource = self
        loadData()
    }
    
    func loadData(){
         // Get Data from firebase
        usuarioTemaService.getData(user: userService.email, completionHandler: { temas in
            self.temas = temas
            self.tvIndice.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tarea", for: indexPath) as! TableViewCellTarea
        let tema = self.temas[indexPath.row]
        cell.lbContent?.text = tema["topic_name"] as? String
        cell.tema = tema
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.temas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func btHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? TableViewCellTarea {
            let view = segue.destination as! ViewControllerTema
            view.tema = cell.tema
        }

    }


}
