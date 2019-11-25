//
//  ViewControllerAvances.swift
//  proyectoFinal
//
//  Created by Layla Tame on 11/17/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit
import Charts
import FirebaseCore
import FirebaseFirestore

class ViewControllerAvances: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvTareas: UITableView!
    @IBOutlet weak var pieChart: PieChartView!
    
    var tareas: [[String:Any]] = []
    var temas: [String] = []
    var correctas: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvTareas.delegate = self
        tvTareas.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*usuarioTemaService.getData(user: userService.email, completionHandler: { temas in
            self.tareas = temas
            self.tvTareas.reloadData()
        })*/
        usuarioTemaService.getData(user: userService.email, completionHandler: { temas in
            self.tareas = temas
            self.tvTareas.reloadData()
            self.loadData()
            self.setUpPieChart()
        })
    }
    
    func loadData() {
        temas = []
        correctas = []
        for tema in tareas {
            let nombre = (tema["topic_name"] as? String)!
            let corr = (tema["correct_answers"] as? Int)!
            temas.append(nombre)
            correctas.append(corr)
        }
    }
    
    @IBAction func regresarHome(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tema") as! CellAvances
        
        let tarea = self.tareas[indexPath.row]
        let corr = tarea["correct_answers"] as! Int
        let incorr = tarea["wrong_answers"] as! Int
        
        var progreso: Float = 0
        let tot = corr + incorr
        if tot != 0 {
            progreso = Float(corr / tot)
        }
        
        cell.lbTema.text = tarea["topic_name"] as? String //nombres[indexPath.row]
        if tarea["topic_hasImage"] as! Bool {
            let url = URL(string: tarea["topic_image"] as! String)
            cell.ivImagen.load(url: url!)
        }
        
    cell.pvProgress.setProgress(progreso, animated: true)
    cell.lbCorrectas.text = String(corr)
    cell.lbTotal.text = String(tot)
        return cell
    }
    
    func setUpPieChart(){
        pieChart.chartDescription?.enabled = false
        pieChart.drawHoleEnabled = false
        pieChart.rotationAngle = 0
        pieChart.rotationEnabled = false
        pieChart.isUserInteractionEnabled = false
        pieChart.entryLabelColor = UIColor.black
        
        pieChart.legend.enabled = false
        
        var entries: [PieChartDataEntry] = Array()
        var i: Int = 0
        for tema in temas {
            entries.append(PieChartDataEntry(value: Double(correctas[i]), label: tema))
            i = i+1
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = [ UIColor.purple, UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.lightGray, UIColor.brown]
        dataSet.drawValuesEnabled = false
        
        pieChart.data = PieChartData(dataSet: dataSet)
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
