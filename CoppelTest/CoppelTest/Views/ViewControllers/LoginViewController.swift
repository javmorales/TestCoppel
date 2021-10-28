//
//  LoginViewController.swift
//  CoppelTest
//
//  Created by Javier Morales on 26/10/21.
//

import UIKit

class LoginViewController: CoppelBaseViewController {
    
    @UsesAutoLayout
    var loginView =  LoginTextFieldView()
    
    var viewModel = LoginVCViewModel()
        
    var label: UILabel = {
        let label = UILabel()
        label.text = "Error password/user"
        label.textColor = .black
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    
        viewModel.loadingStatus.bind { [weak self] (loadingStatus) in
            switch loadingStatus {
            case .complete:
                self?.hideSpinner()
            case .loading:
                self?.showSpinner()
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        self.title = "Login"
        
        self.view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: loginView.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        label.isHidden = true
        loginView.delegate = self
    }

}

extension LoginViewController: LoginViewProtocol {
    func updateLoadingStatus(status: LoadingStatus) {
        viewModel.loadingStatus.value = status
    }
    
    func loginComplete(result: LoginStatus) {
        let resultVC = ResultViewController()
        let defaults = UserDefaults.standard
        defaults.set(result.value(), forKey: "token")
        self.navigationController?.pushViewController(resultVC, animated: true)
    }

    func promptAlert(title: String?, message: String?) {
        label.isHidden = false
    }
}


