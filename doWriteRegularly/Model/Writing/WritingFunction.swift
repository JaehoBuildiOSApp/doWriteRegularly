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
    
    static func readWritings(completion: @escaping ()->()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.writingModels.count == 0 {
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:MM a"
                dateFormatter.locale = Locale(identifier: "ko")
                let currentTime = dateFormatter.string(from: date)
                    
                Data.writingModels.append(WritingModel(title: "일기", alarmTime: "\(currentTime)"))
                Data.writingModels.append(WritingModel(title: "소설", alarmTime: "\(currentTime)"))
//1                Data.writingModels.append(WritingModel(title: "일기", alarmTime1: date))
//1                Data.writingModels.append(WritingModel(title: "소설", alarmTime1: date))

            }
        }
        DispatchQueue.main.async {
            completion()
        }
    }
    
    static func updateWriting(at index: Int, title: String, alarmTime: String) {
//1    static func updateWriting(at index: Int, title: String, alarmTime1: Date) {
        Data.writingModels[index].title = title
        Data.writingModels[index].alarmTime = alarmTime
//1        Data.writingModels[index].alarmTime1 = alarmTime1
    }
    
    static func deleteWriting(index: Int) {
        Data.writingModels.remove(at: index)
    }
}
