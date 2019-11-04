//
//  ViewControllerResultados.swift
//  proyectoFinal
//
//  Created by Layla Tame on 10/12/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit

class ViewControllerResultados: UIViewController {

    var answers: [answerChosen] = []
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lbCorrectas: UILabel!
    @IBOutlet weak var lbIncorrectas: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let correctas = viewProgress()
        let total = answers.count
        progressBar.setProgress((Float(correctas)/Float(total)), animated: true)
        lbCorrectas.text = String(correctas)
        lbIncorrectas.text = String(total - correctas)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
