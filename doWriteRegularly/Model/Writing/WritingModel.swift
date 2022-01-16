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
//1    var alarmTime1: Date
//2    var noteModels = [NoteModel]()
    
    init(title: String, alarmTime: String) {
//1    init(title: String, alarmTime1: Date) {
        id = UUID()
        self.title = title
        self.alarmTime = alarmTime
//1        self.alarmTime1 = alarmTime1
    }
}
