//
//  topics.swift
//  proyectoFinal
//
//  Created by Alumno on 11/8/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import Foundation

import Foundation

class Topic: NSObject {
    let content: String
    let hasImage: Bool
    let id : String

    // init that takes a Dictionary
    init(dictionary: [String:Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.content = dictionary["content"] as? String ?? ""
        self.hasImage = dictionary["hasImage"] as? Bool ?? false
    }
}
