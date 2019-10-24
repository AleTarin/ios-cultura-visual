//
//  question.swift
//  proyectoFinal
//
//  Created by Alumno on 10/16/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit

class Question: NSObject {
    let content: String?
    let correctAnswer: Int?
    let homework: String?
    let topic: String?
    let image: String?
    
    var answers: [Answer]?

    // init that takes a Dictionary
    init(dictionary: [String:Any]) {
    
        // set the one with a default
    self.content = dictionary["content"] as? String ?? ""
    self.correctAnswer = dictionary["correctAnswer"] as? Int ?? 0
    self.homework = dictionary["homework"] as? String ?? "undefined"
    self.topic = dictionary["topic"] as? String ?? "undefined"
    self.image = dictionary["image"] as? String ?? ""
    let generic = Answer(dictionary: ["content" : "Incomplete"])
    
        
    let ans = dictionary["answers"] as! [[String: Any]]?
        
    // Declare answers as generics
    var a1 = generic
    var a2 = generic
    var a3 = generic
    var a4 = generic
        
        // Check if they exists
    if let aux = ans?[0]{ a1 = Answer(dictionary: aux)}
    if let aux = ans?[1]{ a2 = Answer(dictionary: aux)}
    if let aux = ans?[2]{ a3 = Answer(dictionary: aux)}
    if let aux = ans?[3]{ a4 = Answer(dictionary: aux)}
    
    // Update answers
    self.answers = [a1, a2, a3, a4]
    }
}

class Answer: NSObject {
    let content: String
    let isImage: Bool

    // init that takes a Dictionary
    init(dictionary: [String:Any]) {
      // set the Optional ones
      self.content = dictionary["content"] as? String ?? ""
      self.isImage = dictionary["isImage"] as? Bool ?? false
    }
}


