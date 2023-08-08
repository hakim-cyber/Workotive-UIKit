//
//  DataManager.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/7/23.
//

import UIKit


class DataManager:ObservableObject{
    private(set) var days:[Day] = [Day(id: 1, muscles: []),Day(id: 2, muscles: []),Day(id: 3, muscles: []),Day(id: 4, muscles: []),Day(id: 5, muscles: [])]
     
    init() {
        self.days =  DataManager.loadDays()
    }
   static func loadDays()->[Day]{
       var days:[Day] = []
       
       print("loaded")
       return days
    }
}
