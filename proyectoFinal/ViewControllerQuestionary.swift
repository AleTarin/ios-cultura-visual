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

class ViewControllerQuestionary: UIViewController {
    var db: Firestore!
    var preguntas: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        
        db.collection("preguntas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    print("\(document.documentID) => \(document.data())")
                    print(data)
                    self.preguntas.append(data)
                }
            }
            print(self.preguntas)
        }

        // Do any additional setup after loading the view.
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
