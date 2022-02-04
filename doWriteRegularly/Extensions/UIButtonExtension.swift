//
//  UIButtonExtension.swift
//  doWriteRegularly
//
//  Created by Jaeho Jung on 2021/12/19.
//

import UIKit

extension UIButton {

    func createFloatingActionButton() {
        backgroundColor = UIColor(named: "Edit")
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
        tintColor = .white

    }

}
