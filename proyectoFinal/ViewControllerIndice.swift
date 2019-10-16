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
    
    
    var db: Firestore!
    
    // Array de preguntas
    // Cada pregunta es un dictionary
    var tareas: [[String:Any]] = []
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvIndice.delegate = self
        tvIndice.dataSource = self
        // Initialize firebase db
        db = Firestore.firestore()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
         // Get Data from firebase
          db.collection("homeworks").getDocuments() { (querySnapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
              } else {
                  for document in querySnapshot!.documents {
                      let data = document.data()
                     
                     // Save data from all questions
                      self.tareas.append(data)
                  }
              }
            
            self.tvIndice.reloadData()
            
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tarea", for: indexPath) as! TableViewCellTarea
        let tarea = tareas[indexPath.row]
        cell.lbContent?.text = tarea["content"] as? String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
