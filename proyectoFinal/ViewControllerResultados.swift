//
//  ViewControllerResultados.swift
//  proyectoFinal
//
//  Created by Layla Tame on 10/12/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit
import UICircularProgressRing


class ViewControllerResultados: UIViewController {
    
    // From segue
    var answers: [answerChosen] = []
    var tema = [String: Any]()
    var timeLeft = 0
    var viewControl: String = ""
    
    var corrects = 0
    var wrong = 0
    var total = 0
    var score = 0
    var progress:Float = 0
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lbCorrectas: UILabel!
    @IBOutlet weak var lbIncorrectas: UILabel!
    @IBOutlet weak var otProgress: UICircularProgressRing!
    @IBOutlet weak var lbPuntaje: UILabel!
    @IBOutlet weak var btnRespuestas: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        otProgress.style = .ontop
        otProgress.backgroundColor = self.view.backgroundColor
        otProgress.maxValue = 100
        otProgress.outerRingColor = .gray
        otProgress.innerRingColor = .yellow
        otProgress.outerRingWidth = 20
        otProgress.innerRingWidth = 13
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        otProgress.startProgress(to: CGFloat(progress*100), duration: 4.0)
    }
    
    func viewProgress() -> Int {
        var correct = 0
        for ans in answers {
            if ans.chosen == ans.correct {
                correct += 1
            }
        }
        return correct
    }
    
    func loadData() {
        if(viewControl == "resultados"){
            corrects = tema["correct_answers"] as! Int
            wrong = tema["wrong_answers"] as! Int
            total = corrects + wrong
            progress = corrects != 0 && total != 0 ? Float(corrects)/Float(total) : 0
            score = tema["score"] as! Int
            btnRespuestas.setTitle("Regresar", for: .normal)
        }
        else{
            corrects = viewProgress()
            score = corrects * 1000 + timeLeft
            total = answers.count
            wrong = total - corrects
            progress = corrects != 0 && total != 0 ? Float(corrects)/Float(total) : 0

            let isBetter = score > (tema["score"] as! Int)
            // Only update if score was bigger
            if isBetter {
                usuarioTemaService.updateData(user: userService.email, topic_id: tema["topic_id"] as! String, updatedData: [
                    "correct_answers": corrects,
                    "wrong_answers": wrong,
                    "questions_number": total,
                    "complete": progress == 1,
                    "timestamp": Date().description,
                    "score": score
                ])
            }
        }
        
        lbCorrectas.text = String(corrects)
        lbIncorrectas.text = String(wrong)
        lbPuntaje.text = "Puntos: \(String(score))"
        progressBar.setProgress(progress, animated: true)
    }
        
    @IBAction func moveBack(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }

}
