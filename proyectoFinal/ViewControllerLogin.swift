//
//  ViewControllerLogin.swift
//  proyectoFinal
//
//  Created by Alumno on 10/22/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ViewControllerLogin: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    var temas = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        temasService.getTemas(completionHandler: {
            result in
            self.temas = result
        })
    }
    
    @IBAction func onLogin(_ sender: Any) {
        //1.
        if self.tfEmail.text == "" || self.tfPassword.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Por favor introduce email y contraseña", preferredStyle: .alert)
                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                 alertController.addAction(defaultAction)
                 self.present(alertController, animated: true, completion: nil)
         } else {
            Auth.auth().signIn(withEmail: self.tfEmail.text!, password: self.tfPassword.text!) { (user, error) in
                if error == nil {
                    userService.setEmail(email: self.tfEmail.text!)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                } else {
                     let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                     alertController.addAction(defaultAction)
                     self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func onRegister(_ sender: Any) {
        let alert = UIAlertController(title: "Nuevo Usuario", message: "Introduce tus datos por favor", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Guardar", style: .default) { action in
            let emailField = alert.textFields![0]
            let email = emailField.text!
            let passwordField = alert.textFields![1]
           //3.
            Auth.auth().createUser(withEmail: email, password: passwordField.text!) { user, error in
                if error == nil {
                    userService.createUser(email: email, temas: self.temas )
                    self.tfEmail.text = email
                    self.tfPassword.text = passwordField.text!
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default)
        alert.addTextField { textEmail in textEmail.placeholder = "email" }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "contraseña"
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
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
