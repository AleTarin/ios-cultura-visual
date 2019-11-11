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
    var saveAnswers: [answerChosen] = []
    //var index : Int!
    var backColors: [backgroundColors] = []
    
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
                    
                    let pregunta = Question(dictionary: data)
                self.preguntas.append(pregunta)
                    self.saveAnswers.append(answerChosen(chosen: -1, correct: -2, pregunta: pregunta.content!))
                    self.backColors.append(backgroundColors(btn1: UIColor.lightGray, btn2: UIColor.lightGray, btn3: UIColor.lightGray, btn4: UIColor.lightGray))
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

        cell.setAnswer(answer: pregunta.answers!, question: pregunta)
        cell.delegate = self
        
        /*
        saveAnswers.append(answerChosen(chosen: -1, correct: -2, pregunta: pregunta.content!))
        backColors.append(backgroundColors(btn1: UIColor.lightGray, btn2: UIColor.lightGray, btn3: UIColor.lightGray, btn4: UIColor.lightGray))
        */
        cell.btnRes1.backgroundColor = backColors[indexPath.row].btn1
        cell.btnRes2.backgroundColor = backColors[indexPath.row].btn2
        cell.btnRes3.backgroundColor = backColors[indexPath.row].btn3
        cell.btnRes4.backgroundColor = backColors[indexPath.row].btn4

        
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
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    @IBAction func finalizar(_ sender: UIButton) {
        var ind = 0
        for ans in saveAnswers {
            
            if ans.chosen == ans.correct {
                let color = UIColor.green
                if ans.chosen == 0 {
                    backColors[ind].btn1 = color
                    backColors[ind].btn2 = UIColor.lightGray
                    backColors[ind].btn3 = UIColor.lightGray
                    backColors[ind].btn4 = UIColor.lightGray
                }
                if ans.chosen == 1 {
                    backColors[ind].btn2 = color
                    backColors[ind].btn1 = UIColor.lightGray
                    backColors[ind].btn3 = UIColor.lightGray
                    backColors[ind].btn4 = UIColor.lightGray
                }
                if ans.chosen == 2 {
                    backColors[ind].btn3 = color
                    backColors[ind].btn1 = UIColor.lightGray
                    backColors[ind].btn2 = UIColor.lightGray
                    backColors[ind].btn4 = UIColor.lightGray
                }
                if ans.chosen == 3 {
                    backColors[ind].btn4 = color
                    backColors[ind].btn1 = UIColor.lightGray
                    backColors[ind].btn2 = UIColor.lightGray
                    backColors[ind].btn3 = UIColor.lightGray
                }
            }
            else {
                let correct = UIColor.green
                let wrong = UIColor.red
                if ans.chosen == 0 {
                    backColors[ind].btn1 = wrong
                    backColors[ind].btn2 = UIColor.lightGray
                    backColors[ind].btn3 = UIColor.lightGray
                    backColors[ind].btn4 = UIColor.lightGray
                }
                if ans.chosen == 1 {
                    backColors[ind].btn2 = wrong
                    backColors[ind].btn1 = UIColor.lightGray
                    backColors[ind].btn3 = UIColor.lightGray
                    backColors[ind].btn4 = UIColor.lightGray
                }
                if ans.chosen == 2 {
                    backColors[ind].btn3 = wrong
                    backColors[ind].btn1 = UIColor.lightGray
                    backColors[ind].btn2 = UIColor.lightGray
                    backColors[ind].btn4 = UIColor.lightGray
                }
                if ans.chosen == 3 {
                    backColors[ind].btn4 = wrong
                    backColors[ind].btn2 = UIColor.lightGray
                    backColors[ind].btn3 = UIColor.lightGray
                    backColors[ind].btn1 = UIColor.lightGray
                }
                
                if ans.correct == 0 {
                    backColors[ind].btn1 = correct
                }
                if ans.correct == 1 {
                    backColors[ind].btn2 = correct
                }
                if ans.correct == 2 {
                    backColors[ind].btn3 = correct
                }
                if ans.correct == 3 {
                    backColors[ind].btn4 = correct
                }
                
            }
            
            ind += 1
        }
        self.tvQuestionario.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewResultados = segue.destination as! ViewControllerResultados
        viewResultados.answers = saveAnswers
    }
    
    

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
    func tapButton1(title: Answer, question: String, corr: Int) {
        var currentIndex = 0
        for ans in saveAnswers {
            if ans.pregunta == question {
                let answer = answerChosen(chosen: 0, correct: corr, pregunta: question)
                saveAnswers[currentIndex] = answer
            }
            currentIndex += 1
        }
    }
    
    func tapButton2(title: Answer, question: String, corr: Int) {
        var currentIndex = 0
        for ans in saveAnswers {
            if ans.pregunta == question {
                let answer = answerChosen(chosen: 1, correct: corr, pregunta: question)
                saveAnswers[currentIndex] = answer
            }
            currentIndex += 1
        }
    }
    
    func tapButton3(title: Answer, question: String, corr: Int) {
        var currentIndex = 0
        for ans in saveAnswers {
            if ans.pregunta == question {
                let answer = answerChosen(chosen: 2, correct: corr, pregunta: question)
                saveAnswers[currentIndex] = answer
            }
            currentIndex += 1
        }
    }
    
    func tapButton4(title: Answer, question: String, corr: Int) {
        //print(title.content)
        //print(question)
        var currentIndex = 0
        for ans in saveAnswers {
            if ans.pregunta == question {
                let answer = answerChosen(chosen: 3, correct: corr, pregunta: question)
                saveAnswers[currentIndex] = answer
            }
            currentIndex += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("YA CARGO")
        /*if saveAnswers.count == 0 {
            //deshabilitar el escoger respuestas
            //Quitar el boton finalizar
            //Parar el timer
        
        }*/
 
        //for cell in backColor
        
    }
}
