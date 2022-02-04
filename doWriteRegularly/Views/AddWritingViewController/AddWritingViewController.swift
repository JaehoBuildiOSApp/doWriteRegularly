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
    
    var days: [Int] = []
    var daysString: [String] = []
    
    enum weekDays: Int {
        case sunday = 0
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday

        
        func description() -> String {
            switch self {
            case .sunday:
                return "일"
            case .monday:
                return "월"
            case .tuesday:
                return "화"
            case .wednesday:
                return "수"
            case .thursday:
                return "목"
            case .friday:
                return "금"
            case .saturday:
                return "토"
            }
        }
    }
    
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
        }
        
        let time = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "a hh:MM"
        
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
        dateFormatter.dateFormat = "a hh:MM"
        let timeChosen = dateFormatter.string(from: sender.date)
        timeField.text = timeChosen

    }
    
    @IBAction func days(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected

        //google, "How do I remove button selected state when clicked?"
        if sender.isSelected {
            sender.backgroundColor = UIColor.lightGray
            days.append(sender.tag)
        } else {
            days = days.filter {$0 != sender.tag}
            sender.backgroundColor = UIColor.white
        }
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
            
            WritingFunctions.updateWriting(at: index, title: newWritingName, alarmTime: timeField.text!, alarmDay: days, alarmDayName: daysString)
            print(days)
            
        } else {
            
            days.sort()
            let dayDict = [0:"일", 1:"월", 2:"화", 3:"수", 4:"목", 5:"금", 6:"토"]
            var currentDayNameArray: [String] = []
            for i in days {
                let temp = dayDict[i]
                currentDayNameArray.append(temp!)
            }
            
            WritingFunctions.createWriting(writingModel: WritingModel(title: newWritingName, alarmTime: timeField.text!, alarmDay: days, alarmDayName: currentDayNameArray))
            print(days)
        }
        
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
