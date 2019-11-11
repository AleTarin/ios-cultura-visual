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

    var answers: [answerChosen] = []
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lbCorrectas: UILabel!
    @IBOutlet weak var lbIncorrectas: UILabel!
    @IBOutlet weak var otProgress: UICircularProgressRing!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let correctas = viewProgress()
        let total = answers.count
        progressBar.setProgress((Float(correctas)/Float(total)), animated: true)
        lbCorrectas.text = String(correctas)
        lbIncorrectas.text = String(total - correctas)
        
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
