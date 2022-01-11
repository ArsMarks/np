//
//  FlatReserveViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 19.12.2021.
//

import UIKit
import SnapKit

class FlatReserveViewController: UIViewController {
    
    let flatReserveView = FlatReserveView()
    
    private var flatID = ""
    
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    
    init(flatID: String) {
        super.init(nibName: nil, bundle: nil)
        self.flatID = flatID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = flatReserveView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtons()
        
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    private func setupButtons() {
        flatReserveView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        [flatReserveView.registrationForViewButton, flatReserveView.callBackButton].forEach { buttons in
            buttons.addTarget(self, action: #selector(reserveButtonTapped(_:)), for: .touchUpInside)
        }
        flatReserveView.callButton.addTarget(self, action: #selector(callButtonTapped(_:)), for: .touchUpInside)
        flatReserveView.telegramButton.addTarget(self, action: #selector(telegramButtonTapped(_:)), for: .touchUpInside)
        flatReserveView.whatsAppButton.addTarget(self, action: #selector(whatsAppButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func callButtonTapped(_ sender: UIButton) {
        let phoneURL = URL(string: "tel:+7(812)704-86-78")!
        UIApplication.shared.open(phoneURL)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func telegramButtonTapped(_ sender: UIButton) {
        let tgURL = URL(string: "tg://resolve?domain=evspbbot")!
        if UIApplication.shared.canOpenURL(tgURL) {
            UIApplication.shared.open(tgURL)
        } else {
            showAlert(title: "Ошибка", message: "У вас не установлен Telegram")
        }
    }
    
    @objc func whatsAppButtonTapped(_ sender: UIButton) {
        let whatsAppURL = URL(string: "whatsapp://78122442010")!
        if UIApplication.shared.canOpenURL(whatsAppURL) {
            UIApplication.shared.open(whatsAppURL)
        } else {
            showAlert(title: "Ошибка", message: "У вас не установлен WhatsApp")
        }
    }

    @objc func cancelButtonTapped(_ sender: UIButton) {
        presentationController?.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func reserveButtonTapped (_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        let slideVC = ReserveFormViewController(flatID: flatID, title: title)
        slideVC.modalPresentationStyle = .popover
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else { return }
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)

        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 900 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 420)
                }
            }
        }
    }
}
