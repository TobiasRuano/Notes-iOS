//
//  ViewController + Extension.swift
//  Notes
//
//  Created by Tobias Ruano on 07/07/2021.
//

import UIKit

extension UIViewController {
    
    func alert(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
