//
//  UIViewController+Extension.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation
import UIKit
extension UIViewController{
    
    func setViewControllerTitle(to title:String, fontColor: UIColor = UIColor.black) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 25))
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.font =  UIFont.italicSystemFont(ofSize: 20.0)
        titleLabel.textColor = fontColor
        self.navigationItem.titleView = titleLabel
    }
    func showAlert(_ message: String) {
        self.showAlert(title: "Alert", message: message)
    }
    
    func showAlert(title: String, message: String, okTitle: String = "OK", okHandler: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        self.present(alert, animated: true, completion: nil)
    }
}
