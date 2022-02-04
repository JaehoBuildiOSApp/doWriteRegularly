//
//  UIViewExtensions.swift
//  doWriteRegularly
//
//  Created by Jaeho Jung on 2021/12/18.
//

import UIKit

extension UIView {
    func addShadowAndRoundedCorners() {
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }
}


