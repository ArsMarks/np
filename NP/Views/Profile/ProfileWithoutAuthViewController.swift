//
//  ProfileWithoutAuthViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 09.12.2021.
//

import UIKit
import SnapKit
import Firebase

class ProfileWithoutAuthViewController: AuthorizationViewController {
    
    override func loadView() {
        super.loadView()
        view = profileWithoutAuthView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Вход"
        profileWithoutAuthView.phoneTextField.delegate = self
    }
    
    override func updateTextField(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardDidHideNotification {
            profileWithoutAuthView.enterButton.snp.remakeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
                make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
                make.height.equalTo(50)
                
            }
        } else {
            profileWithoutAuthView.enterButton.snp.remakeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-1 * (keyboardFrame.height))
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
                make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
                make.height.equalTo(50)
            }
        }
    }
    
}
