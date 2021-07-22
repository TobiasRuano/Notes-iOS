//
//  UIView + Extensions.swift
//  Notes
//
//  Created by Tobias Ruano on 07/07/2021.
//

import UIKit

extension UIView {
    
  func dropShadow() {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: 0, height: 0)
      layer.shadowRadius = 5
      //layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = UIScreen.main.scale
  }
    
}
