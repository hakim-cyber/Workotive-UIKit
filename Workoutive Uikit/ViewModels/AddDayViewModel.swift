//
//  AddDayViewModel.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/9/23.
//

import Foundation


class AddDayVM:ObservableObject{
    var days:[Day] = []
    var pickedDate = Date()
    var availibleDays:[Int] = [1,2,3,4,5,6,7]
    
    var pickedNewDay:Int = 1
    
    func setup(days:[Day]){
        let newAvailible = availibleDays.filter({i in
            !days.contains(where: {$0.id == i}) })
        availibleDays = newAvailible
        self.days = days
        
        self.pickedNewDay = self.availibleDays[0]
        
    }
}
