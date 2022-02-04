//
//  WritingModel.swift
//  doWriteRegularly
//
//  Created by Jaeho Jung on 2021/12/17.
//

import Foundation

class WritingModel {
    var id: UUID
    var title: String!
    var alarmTime: String!
    var alarmDay: [Int] = []
    var alarmDayName: [String] = []
    
    init(title: String, alarmTime: String, alarmDay: [Int], alarmDayName: [String]) {
        id = UUID()
        self.title = title
        self.alarmTime = alarmTime
        self.alarmDay = alarmDay
        self.alarmDayName = alarmDayName
    }
}
