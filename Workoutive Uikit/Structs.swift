//
//  Structs.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/7/23.
//

import Foundation

struct Day:Codable,Identifiable{
    let id:Int
    var muscles:[Muscle]
    
    static let saveKey = "Days"
    
}

struct Muscle: Codable,Identifiable{
    var id = UUID()
    let muscle:String
    var exercises:[ExerciseApi]

    
}


struct ExerciseApi: Codable,Identifiable,Hashable{
       let bodyPart:String
       let equipment:String
       let gifUrl:String
       let id:String
       let name:String
       let target:String
       
       var sets:Int? = 0
       var repeatCount:Int? = 0
       
       static var defaultExercise = ExerciseApi(bodyPart: "Back", equipment: "Dumbell", gifUrl: "sdssdsdsd", id: "001", name: "Dumbell Press", target: "back")
      
       func hash(into hasher: inout Hasher) {
               hasher.combine(id)
           }
   }
