//
//  db.swift
//  proyectoFinal
//
//  Created by Alumno on 11/7/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import Foundation
import FirebaseFirestore

// Contiene solo la informacion del tema
let temasService = temasServ()
class temasServ {
    var dbRef = Firestore.firestore().collection("temas")
    var temas = [Topic]()
    func getTemas( completionHandler: @escaping ([[String: Any]]) -> Void){
        var temas = [[String:Any]]()
        self.dbRef.getDocuments() { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                let data = document.data()
                temas.append(data)
            }
            completionHandler(temas)
        }
    }
    
    func setTemas (temas:[[String: Any]]){
        // Convierte cada tema a objeto y lo almacena
        for tema in temas {
            self.temas.append(Topic(dictionary: tema))
        }
    }
}

// Contiene toda la informacion del cuestionario
let usuarioTemaService = usuarioTemaServ()
class usuarioTemaServ {
    private var dbRef = Firestore.firestore().collection("usuario_tema")
    var temas = [[String: Any]]()
    var temaActual = [String: Any]()
    
    func getData( user: String, completionHandler: @escaping ([[String: Any]]) -> Void){
        var temas = [[String: Any]]()
        dbRef.whereField("user", isEqualTo: user).getDocuments() { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                let data = document.data()
                temas.append(data)
            }
            self.temas = temas
            completionHandler(self.temas)
        }
    }
    
    func updateData( user: String, topic_id: String, updatedData: [String: Any] ) {
        dbRef.whereField("topic_id", isEqualTo: topic_id).whereField("user", isEqualTo: user).getDocuments(completion: {
            (querySnapshot, err) in
            for document in querySnapshot!.documents {
                let uid = document.documentID
                self.dbRef.document(uid).updateData(updatedData)
            }
        })
    }
}


let questionService = questionServ()
class questionServ {
    private var dbRef = Firestore.firestore().collection("preguntas")
    var questions: [Question] = []
    
    func getQuestions(topic: String?, completionHandler: @escaping ([Question]) -> Void) {
        var preguntas: [Question] = []
        var collectionRef = dbRef
        if topic != nil { // If topic is not nil, filter by that topic
            collectionRef = dbRef.whereField("topic", isEqualTo: topic!) as! CollectionReference
        }
        
        collectionRef.getDocuments() { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                let data = document.data()
                preguntas.append(Question(dictionary: data))
            }
            self.questions = preguntas
            completionHandler(self.questions)
        }
    }
}
    
let userService = userServ()
class userServ {
    var email = ""
    private var dbRef = Firestore.firestore().collection("usuarios")
    private var dbRefTemas = Firestore.firestore().collection("usuario_tema")

    func createUser(email: String, temas: [[String: Any]]) {
        for t in temas {
            // Para cada tema, crea una tabla de relacion usuario_tema con valores defaults
            dbRefTemas.addDocument(data:
                [
                    "complete": false,
                    "score": 0,
                    "correct_answers": 0,
                    "wrong_answers": 0,
                    "questions_number": 0,
                    "topic_id": t["id"] as! String,
                    "topic_name": t["content"] as! String,
                    "user": email,
                    "timestamp": ""
                ]
            )
        }
        // Crea el usuario
        dbRef.document(email).setData(
            [
                "email": email
            ]
        )
    }
    
    func setEmail(email:String) {
        self.email = email

    }

}



