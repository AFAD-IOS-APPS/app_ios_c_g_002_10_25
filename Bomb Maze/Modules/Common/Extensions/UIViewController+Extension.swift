//
//  UIViewController+Extension.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 21/10/2025.
//

import UIKit

extension UIViewController {
    func adjustForKeyboard(notification: Notification, viewToMove: UIView) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curveRawValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
        
        let animationOptions = UIView.AnimationOptions(rawValue: curveRawValue << 16)
        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
        let offset: CGFloat = isKeyboardShowing ? -keyboardFrame.height / 3 : 0
        
        UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: {
            viewToMove.frame.origin.y = offset
        })
    }
    
    func dismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

