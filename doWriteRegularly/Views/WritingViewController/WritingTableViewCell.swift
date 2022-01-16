//
//  WritingTableViewCell.swift
//  doWriteRegularly
//
//  Created by Jaeho Jung on 2021/12/17.
//

import UIKit

class WritingTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.addShadowAndRoundedCorners()
        cardView.backgroundColor = Theme.accent
        
        titleLabel.font = UIFont(name: Theme.mainBoldFontName, size: 45)
        timeLabel.font = UIFont(name: Theme.mainFontName, size: 20)

    }
    
    func setup(writingModel: WritingModel) {
        titleLabel.text = writingModel.title
        timeLabel.text = writingModel.alarmTime

//        timeLabel.text =
//        let date = writingModel.alarmTime
//        let formatter = DateFormatter()
//        formatter.dateFormat = "hh:MM a"
//        timeLabel.text = formatter.string(from:date)+"부터"
//1        timeLabel1.text = String(writingModel.alarmTime1)
    }
}
