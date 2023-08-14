//
//  DataManager.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/7/23.
//

import UIKit


class DataManager:ObservableObject{
    private(set) var days:[Day] = [Day(id: 1, muscles: []),Day(id: 2, muscles: [])]
     
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
    func removeDay(day:Day){
       
        self.days.removeAll(where: {$0.id == day.id})
        
    }
    func addMuscleTo(dayID:Int,muscle:Muscle){
        if let index = self.days.firstIndex(where: {$0.id == dayID}){
            self.days[index].muscles.append(muscle)
        }
    }
    func deleteMuscleAt(dayID:Int,muscle:Muscle){
        if let index = self.days.firstIndex(where: {$0.id == dayID}){
            self.days[index].muscles.removeAll(where: {$0.id == muscle.id})
        }
    }
}
