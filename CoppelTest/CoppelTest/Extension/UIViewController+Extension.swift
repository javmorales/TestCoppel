//
//  UIViewController+Extension.swift
//  CoppelTest
//
//  Created by Javier Morales on 26/10/21.
//

import UIKit

extension UIViewController {
    public func alert(title: String?, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(alertAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
