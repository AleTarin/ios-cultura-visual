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
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lbCorrectas: UILabel!
    @IBOutlet weak var lbIncorrectas: UILabel!
    @IBOutlet weak var otProgress: UICircularProgressRing!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let correctas = viewProgress()
        let total = answers.count
        let incorrectas = total - correctas
        let progress = Float(correctas)/Float(total)
        
        progressBar.setProgress(progress, animated: true)
        lbCorrectas.text = String(correctas)
        lbIncorrectas.text = String(incorrectas)
        
        usuarioTemaService.updateData(user: userService.email, topic_id: tema["topic_id"] as! String, updatedData: [
            "correct_answers": correctas,
            "wrong_answers": incorrectas,
            "questions_number": total,
            "complete": progress == 1,
            "timestamp": Date().description,
            "score": correctas * 1000 - incorrectas * 1000 + timeLeft * 10
        ])

        /*otProgress.style = .ontop
        otProgress.backgroundColor = self.view.backgroundColor
        otProgress.maxValue = 100
        otProgress.outerRingColor = .gray
        otProgress.innerRingColor = .yellow
        otProgress.outerRingWidth = 20
        otProgress.innerRingWidth = 13*/
        
        //otProgress.startProgress(to: CGFloat((correctas/total)*100), duration: 4.0)
    }
    
    func viewProgress() -> Int {
        var correct = 0
        print(answers.count)
        for ans in answers {
            if ans.chosen == ans.correct {
                correct += 1
            }
            print(ans.chosen)
            print(ans.correct)
        }
        
        return correct
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        let prog = (viewProgress() / answers.count) * 100
        
        otProgress.startProgress(to: CGFloat(prog), duration: 4.0)
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
