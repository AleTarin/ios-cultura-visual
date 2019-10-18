//
//  ViewControllerQuestionary.swift
//  proyectoFinal
//
//  Created by Alumno on 10/9/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewControllerQuestionary: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvQuestionario: UITableView!
    var db: Firestore!
    @IBOutlet weak var timeLabel: UILabel!
    var timer:Timer?
    var timeLeft: Int!
    // Array de preguntas
    // Cada pregunta es un dictionary
    var preguntas: [Question] = []
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvQuestionario.delegate = self
        tvQuestionario.dataSource = self
        // Initialize firebase db
        db = Firestore.firestore()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
         // Get Data from firebase
          db.collection("preguntas").getDocuments() { (querySnapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
              } else {
                  for document in querySnapshot!.documents {
                      let data = document.data()
                     
                     // Save data from all questions
                self.preguntas.append(Question(dictionary: data))
                  }
              }
            self.timeLeft = self.preguntas.count * 60
            self.tvQuestionario.reloadData()
            self.setupTimer()
            
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "question", for: indexPath) as! questionTableViewCell
        let pregunta = preguntas[indexPath.row]
        let p1 = pregunta.answers![0]
        cell.btnRes1?.setTitle(p1.content, for: .normal)
        let p2 = pregunta.answers![1]
        cell.btnRes2?.setTitle(p2.content, for: .normal)
        let p3 = pregunta.answers![2]
        cell.btnRes3?.setTitle(p3.content, for: .normal)
        let p4 = pregunta.answers![3]
        cell.btnRes4?.setTitle(p4.content, for: .normal)
        cell.imgQuestion?.load(url: URL(string: pregunta.image ?? "" )!)
        
        cell.lbTitle?.text = "Question \(indexPath.row+1):"
        cell.lbContent?.text = pregunta.content

        cell.setAnswer(answer: pregunta.answers!)
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preguntas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }

    @objc func onTimerFires() {
        timeLeft -= 1
        
        timeLabel.text = "\(timeFormatted(timeLeft!)) seconds left"

        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            performSegue(withIdentifier: "resultadosSegue", sender: self)
        } else {
            // do something
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension ViewControllerQuestionary: botonTap {
    func tapButton1(title: Answer) {
        print(title.content)
        //Recibir respuesta seleccionada
         //Verificar si seleccionada es correcta o incorrecta
         //Mandar a un array para la sección de resultados
    }
    
    func tapButton2(title: Answer) {
        print(title.content)

               //Recibir respuesta seleccionada
         //Verificar si seleccionada es correcta o incorrecta
         //Mandar a un array para la sección de resultados
    }
    
    func tapButton3(title: Answer) {
        print(title.content)

        //Recibir respuesta seleccionada
         //Verificar si seleccionada es correcta o incorrecta
         //Mandar a un array para la sección de resultados
    }
    
    func tapButton4(title: Answer) {
        print(title.content)

       //Recibir respuesta seleccionada
         //Verificar si seleccionada es correcta o incorrecta
         //Mandar a un array para la sección de resultados
    }
}
