//
//  AppUIButton.swift
//  doWriteRegularly
//
//  Created by Jaeho Jung on 2021/12/20.
//

import UIKit

class AppUIButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor(named: "Edit")
        layer.cornerRadius = frame.height / 2
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont(name: Theme.mainBoldFontName, size: 30)
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor

    }

}


