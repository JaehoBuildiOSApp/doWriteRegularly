//
//  WritingFunction.swift
//  doWriteRegularly
//
//  Created by Jaeho Jung on 2021/12/17.
//

import UIKit
import Foundation

class WritingFunctions {
    static func createWriting(writingModel: WritingModel) {
        Data.writingModels.append(writingModel)
    }
    
    var dayDict = [0:"일", 1:"월", 2:"화", 3:"수", 4:"목", 5:"금", 6:"토"]
        
    static func readWritings(completion: @escaping ()->()) {

        DispatchQueue.global(qos: .userInteractive).async {
            if Data.writingModels.count == 0 {
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "a hh:MM"
                dateFormatter.locale = Locale(identifier: "ko")
                let currentTime = dateFormatter.string(from: date)
                
                let currentDay = date.dayNumberOfWeek()
                var currentDayArray: [Int] = []
                currentDayArray.append(currentDay!)
//                currentDayArray.sorted()
                
                let dayDict = [0:"일", 1:"월", 2:"화", 3:"수", 4:"목", 5:"금", 6:"토"]
                var currentDayNameArray: [String] = []
                let temp = dayDict[0]
                currentDayNameArray.append(temp!)
                                
                Data.writingModels.append(WritingModel(title: "일기", alarmTime: "\(currentTime)", alarmDay: currentDayArray, alarmDayName: currentDayNameArray))
                Data.writingModels.append(WritingModel(title: "소설", alarmTime: "\(currentTime)", alarmDay: currentDayArray, alarmDayName: currentDayNameArray))
            }
        }
        DispatchQueue.main.async {
            completion()
        }
        print(WritingModel.self)
    }
    
    static func updateWriting(at index: Int, title: String, alarmTime: String, alarmDay: [Int], alarmDayName: [String]) {
        Data.writingModels[index].title = title
        Data.writingModels[index].alarmTime = alarmTime
        Data.writingModels[index].alarmDay = alarmDay
        Data.writingModels[index].alarmDayName = alarmDayName
        
        print(WritingModel.self)
    }
    
    static func deleteWriting(index: Int) {
        Data.writingModels.remove(at: index)
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

