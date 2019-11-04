//
//  ViewControllerLogin.swift
//  proyectoFinal
//
//  Created by Alumno on 10/22/19.
//  Copyright © 2019 Layla Tame. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerLogin: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        //1.
        if self.tfEmail.text == "" || self.tfPassword.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Por favor introduce email y contraseña", preferredStyle: .alert)
                 
                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                 alertController.addAction(defaultAction)
                 
                 self.present(alertController, animated: true, completion: nil)
                 
             } else {
             //2.
            Auth.auth().signIn(withEmail: self.tfEmail.text!, password: self.tfPassword.text!) { (user, error) in
                 //3.
                    if error == nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                        
                    self.present(vc!, animated: true, completion: nil)
                             
                } else {
                 //4.
                 let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                 
                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                 alertController.addAction(defaultAction)
                 
                 self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func onRegister(_ sender: Any) {
        //1.
        let alert = UIAlertController(title: "Nuevo Usuario",
                                      message: "Introduce tus datos por favor",
                                      preferredStyle: .alert)
        //2.
        let saveAction = UIAlertAction(title: "Guardar", style: .default) { action in
        let emailField = alert.textFields![0]
        let passwordField = alert.textFields![1]
       //3.
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                                        }
        }
        //4.
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .default)
        //5.
        alert.addTextField { textEmail in
            textEmail.placeholder = "email"
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "contraseña"
        }
        //6.
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        //7.
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
