//
//  AuthorizationViewController.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 17.02.22.
//

import UIKit

class AuthorizationViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    var viewModel: AuthorizationViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func loginClicked(_ sender: Any) {
//        if validate() {
        openMapViewScreen()
        viewModel.authorization(username: usernameTextField.text ?? .empty, password: passwordTextField.text ?? .empty)
//        }
    }
    
    private func validate() -> Bool {
        var isValid = true
        
        if usernameTextField.text?.isEmpty ?? false {
            isValid = false
            showError(text: "იუზერის სახელის ველი ცარიელია")
        } else if passwordTextField.text?.isEmpty ?? false {
            isValid = false
            showError(text: "პაროლის ველი ცარიელია")
        }
        
        return isValid
    }
    
    private func openMapViewScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MapView", bundle: nil)
        let mapViewController = storyBoard.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        let mapViewModel = MapViewModel()
        mapViewController.viewModel = mapViewModel
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    private func showError(text: String) {
        let alert = UIAlertController(title: "შეცდომა", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "გასაგებია", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
