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
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lbCorrectas: UILabel!
    @IBOutlet weak var lbIncorrectas: UILabel!
    @IBOutlet weak var otProgress: UICircularProgressRing!
    @IBOutlet weak var lbPuntaje: UILabel!
    @IBOutlet weak var btnRespuestas: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let correctas = viewProgress()
        let total = answers.count
        let incorrectas = total - correctas
        let progress = Float(correctas)/Float(total)
        let score = correctas * 1000 + timeLeft
        let isBetter = score > (tema["score"] as! Int)
        let corrects = tema["correct_answers"] as! Int
        let incorrects = tema["wrong_answers"] as! Int
        let score1 = tema["score"] as! Int
        
        progressBar.setProgress(progress, animated: true)
        
        if(viewControl == "resultados"){
            lbCorrectas.text = String(corrects)
            lbIncorrectas.text = String(incorrects)
            lbPuntaje.text = "Puntos: \(String(score1))"
            btnRespuestas.setTitle("Regresar", for: .normal)
        }
        else{
            lbCorrectas.text = String(correctas)
            lbIncorrectas.text = String(incorrectas)
            lbPuntaje.text = "Puntos: \(String(score))"
        }
        
        // Only update if score was bigger
        if isBetter {
            usuarioTemaService.updateData(user: userService.email, topic_id: tema["topic_id"] as! String, updatedData: [
                "correct_answers": correctas,
                "wrong_answers": incorrectas,
                "questions_number": total,
                "complete": progress == 1,
                "timestamp": Date().description,
                "score": score
            ])
        }

        otProgress.style = .ontop
        otProgress.backgroundColor = self.view.backgroundColor
        otProgress.maxValue = 100
        otProgress.outerRingColor = .gray
        otProgress.innerRingColor = .yellow
        otProgress.outerRingWidth = 20
        otProgress.innerRingWidth = 13
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let corrects = tema["correct_answers"] as! CGFloat
        let prog = (CGFloat(viewProgress()) / CGFloat(answers.count)) * 100
        let prog1 = (corrects / CGFloat(answers.count)) * 100
        
        if(viewControl == "resultados"){
            otProgress.startProgress(to: CGFloat(prog1), duration: 4.0)
        }
        else{
            otProgress.startProgress(to: CGFloat(prog), duration: 4.0)
        }
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
        
    @IBAction func moveBack(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
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
