//
//  FlatsExtensions.swift
//  NP
//
//  Created by Рушан Киньягулов on 04.01.2022.
//

import UIKit

extension UIView {
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                              cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
  }
}

extension FlatReserveViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension ReserveFormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.keyboardType == .numberPad {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            let authVC = AuthorizationViewController()
            textField.text = authVC.format(with: "+X (XXX) XXX-XX-XX", phone: newString)
        } else { return true }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIView {
    func setupSublayers() {
        let topLineForPropertyView = CALayer()
        let bottomLineForPropertyView = CALayer()
        topLineForPropertyView.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 1.0)
        bottomLineForPropertyView.frame = CGRect(x: 0.0, y: 110, width: UIScreen.main.bounds.width, height: 1.0)
        [topLineForPropertyView, bottomLineForPropertyView].forEach { layers in
            layers.backgroundColor = Color.brandGray.cgColor
            self.layer.addSublayer(layers)
        }
        topLineForPropertyView.backgroundColor = Color.brandGray.cgColor
        layer.addSublayer(topLineForPropertyView)
    }
}
