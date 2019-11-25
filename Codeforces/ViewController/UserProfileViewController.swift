//
//  ViewController.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 05/10/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import UIKit

class UserProfileViewController:
    UIViewController,
    UITextFieldDelegate
{
    
    let preferredTextField = UITextField.init(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let codeforcesLogo = UIImageView.init(frame: CGRect.zero)
        codeforcesLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(codeforcesLogo)
        codeforcesLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        codeforcesLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 95).isActive = true
        codeforcesLogo.heightAnchor.constraint(equalToConstant: 120).isActive = true
        codeforcesLogo.widthAnchor.constraint(equalToConstant: 120).isActive = true
        codeforcesLogo.image = UIImage(named: "codeforces_logo")
        
        let codeforcesText = UILabel.init(frame: CGRect.zero)
        codeforcesText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(codeforcesText)
        codeforcesText.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        codeforcesText.topAnchor.constraint(equalTo: codeforcesLogo.bottomAnchor, constant: -30).isActive = true
        codeforcesText.text = "Codeforces"
        codeforcesText.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        preferredTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(preferredTextField)
        preferredTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        preferredTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        preferredTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        preferredTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        preferredTextField.layer.cornerRadius =  5
        preferredTextField.layer.borderColor = UIColor.gray.cgColor
        preferredTextField.backgroundColor = .systemBackground
        preferredTextField.layer.borderWidth = 0.8
        preferredTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        preferredTextField.leftViewMode = .always
        preferredTextField.placeholder = "Please enter your preferred handle"
        preferredTextField.delegate = self
        
        let submitButton = UIButton.init(frame: CGRect.zero)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        submitButton.topAnchor.constraint(equalTo: preferredTextField.bottomAnchor, constant: 15).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.layer.cornerRadius = 0.5 * 50
        submitButton.backgroundColor = .blue
        submitButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        var arrowForwardimage = UIImage(named: "arrow_forward.png")
        arrowForwardimage = arrowForwardimage?.withTintColor(.white)
        submitButton.setImage(arrowForwardimage, for: .normal)
        submitButton.addTarget(self, action: #selector(openContestList), for: .touchUpInside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func openContestList() {
        if (preferredTextField.text != nil) {
            self.navigationController?.pushViewController(ContestListViewController.init(preferredHandle: preferredTextField.text!), animated: true)
        }
    }
}

