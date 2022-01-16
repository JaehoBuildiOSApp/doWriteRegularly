//
//  AddWritingViewController.swift
//  doWriteRegularly
//
//  Created by Jaeho Jung on 2021/12/19.
//
//1 해야할 것: 알람 시간을 string이 아니라 Date으로 저장하고 WritingModel, WritingFunction에서도 수정하기
//1 해야할 것: 알람 시간 선택 시 요일도 선택하고,WritingModel, WritingFunction에서도 수정하기
//1 참고하기: 특정 요일에 알람 반복: https://stackoverflow.com/questions/45061324/repeating-local-notifications-for-specific-days-of-week-swift-3-ios-10


import UIKit
//import UserNotifications

@available(iOS 13.4, *)
class AddWritingViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writingTextField: UITextField!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var selectDays: UIStackView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeField: UITextField!
        
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var doneSaving: (()->())?
    var writingIndexToEdit: Int?
    
    public var completion: ((String, Date) -> Void)?
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writingTextField.delegate = self
        
        popupView.addShadowAndRoundedCorners()
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        writingTextField.font = UIFont(name: Theme.mainBoldFontName, size: 30)
        writingTextField.addShadowAndRoundedCorners()
        dayLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        timeLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        
        if let index = writingIndexToEdit {
            let writing = Data.writingModels[index]
            writingTextField.text = writing.title
            
            let date = writing.alarmTime
            timeField.text = date
//1            let date = writing.alarmTime1
//1            let dateFormatter = DateFormatter()
//1            dateFormatter.dateFormat = "hh:MM a"
//1            timeField.text = dateFormatter.string(from: date)
        }
        
        let time = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "hh:MM a"
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueSelected(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        timePicker.preferredDatePickerStyle = .wheels
        timeField.inputView = timePicker
        
        timeField.text = dateFormatter.string(from: time)
        timeField.textColor = .black
        timeField.font = UIFont(name: Theme.mainBoldFontName, size: 30)
        timeField.addShadowAndRoundedCorners()
        
    }
    
    @objc func timePickerValueSelected(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "hh:MM a"
        let timeChosen = dateFormatter.string(from: sender.date)
        timeField.text = timeChosen

    }
    
    @IBAction func days(_ sender: UIButton) {
        
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        guard writingTextField.text != "", let newWritingName = writingTextField.text else {
            writingTextField.layer.borderColor = UIColor.red.cgColor
            writingTextField.layer.borderWidth = 1
            writingTextField.layer.cornerRadius = 5
            return
        }
        
        if let index = writingIndexToEdit {
            WritingFunctions.updateWriting(at: index, title: newWritingName, alarmTime: timeField.text!)
//1            WritingFunctions.updateWriting(at: index, title: newWritingName, alarmTime1: timeField)
        } else {
            WritingFunctions.createWriting(writingModel: WritingModel(title: newWritingName, alarmTime: timeField.text!))
//            WritingFunctions.createWriting(writingModel: WritingModel(title: newWritingName, alarmTime1: timeField))
        }
        
        
        let targetDate = UIDatePicker.self
        
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
        
        notificationCenter.getNotificationSettings { (settings) in
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
