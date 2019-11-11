//
//  questionTableViewCell.swift
//  proyectoFinal
//
//  Created by Alumno on 10/10/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit

protocol botonTap {
    func tapButton1(title: Answer, question: String, corr: Int)
    func tapButton2(title: Answer, question: String, corr: Int)
    func tapButton3(title: Answer, question: String, corr: Int)
    func tapButton4(title: Answer, question: String, corr: Int)
}

class questionTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var btnRes1: UIButton!
    @IBOutlet weak var btnRes2: UIButton!
    @IBOutlet weak var btnRes3: UIButton!
    @IBOutlet weak var btnRes4: UIButton!
    
    var delegate:  botonTap?
    var answerChosen: [Answer]!
    var questionChosen: Question!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setAnswer(answer: [Answer], question: Question){
        answerChosen = answer
        questionChosen = question
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func btn1Tap(_ sender: UIButton) {
        delegate?.tapButton1(title: answerChosen![0], question: questionChosen.content!, corr:  questionChosen.correctAnswer!)
        btnRes1.backgroundColor = UIColor.darkGray
        btnRes2.backgroundColor = UIColor.lightGray
        btnRes3.backgroundColor = UIColor.lightGray
        btnRes4.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func btn2Tap(_ sender: UIButton) {
        delegate?.tapButton2(title: answerChosen![1], question: questionChosen.content!, corr:  questionChosen.correctAnswer!)
        btnRes1.backgroundColor = UIColor.lightGray
        btnRes2.backgroundColor = UIColor.darkGray
        btnRes3.backgroundColor = UIColor.lightGray
        btnRes4.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func btn3Tap(_ sender: UIButton) {
        delegate?.tapButton3(title: answerChosen![2], question: questionChosen.content!, corr:  questionChosen.correctAnswer!)
        btnRes1.backgroundColor = UIColor.lightGray
        btnRes2.backgroundColor = UIColor.lightGray
        btnRes3.backgroundColor = UIColor.darkGray
        btnRes4.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func btn4Tap(_ sender: UIButton) {
        delegate?.tapButton4(title: answerChosen![3], question: questionChosen.content!, corr:  questionChosen.correctAnswer!)
        btnRes1.backgroundColor = UIColor.lightGray
        btnRes2.backgroundColor = UIColor.lightGray
        btnRes3.backgroundColor = UIColor.lightGray
        btnRes4.backgroundColor = UIColor.darkGray
    }
    

}
