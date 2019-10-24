//
//  homework.swift
//  proyectoFinal
//
//  Created by Alumno on 10/22/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import Foundation

class Homework: NSObject {
    let content: String
    let isImage: Bool

    // init that takes a Dictionary
    init(dictionary: [String:Any]) {
      // set the Optional ones
      self.content = dictionary["content"] as? String ?? ""
      self.isImage = dictionary["isImage"] as? Bool ?? false
    }
}
