//
//  DataManager.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/7/23.
//

import UIKit


class DataManager:ObservableObject{
    private(set) var days:[Day] = []
     
    init() {
        
    }
   static func loadDays()->[Day]{
       var days:[Day] = []
       
       print("loaded")
       return days
    }
    func addDays(day:Day){
       
            self.days.append(day)
        
    }
}
