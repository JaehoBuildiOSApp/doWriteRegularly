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
    @IBOutlet weak var weekdayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.addShadowAndRoundedCorners()
        cardView.backgroundColor = Theme.accent
        
        titleLabel.font = UIFont(name: Theme.mainBoldFontName, size: 45)
        timeLabel.font = UIFont(name: Theme.mainFontName, size: 20)
        weekdayLabel.font = UIFont(name: Theme.mainFontName, size: 20)
    }
    
    func setup(writingModel: WritingModel) {
        titleLabel.text = writingModel.title
        timeLabel.text = writingModel.alarmTime + " 글쓰기 시작"
        weekdayLabel.text = "매주 " + writingModel.alarmDayName.joined(separator: ",") + "요일"
    }
}
