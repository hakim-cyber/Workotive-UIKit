//
//  DataManager.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/7/23.
//

import UIKit


class DataManager:ObservableObject{
    private(set) var days:[Day] = [Day(id: 1, muscles: [Muscle(muscle: "back", exercises: [])]),Day(id: 2, muscles: [])]
     
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
    func loadAllExcercises(for bodyPart:String,completion:@escaping([ExerciseApi])-> Void){
        let saveKeyExercises = "exercises"
        var exercises = [ExerciseApi]()
        
        if let savedData = UserDefaults.standard.data(forKey: saveKeyExercises){
            // if value nothing to do
            if let decoded = try? JSONDecoder().decode([ExerciseApi].self, from: savedData){
                exercises = decoded
            }
        }else{
            let headers = [
                "content-type": "application/octet-stream",
                "X-RapidAPI-Key": "d3be8ad012mshea31fdf3fc52d3bp18251bjsn0ff8b0e32a60",
                "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
            ]
            
            guard let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises") else{return}
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            
            
            
            URLSession.shared.dataTask(with: request as URLRequest){data,_,error in
                guard let data = data else{return}
                if let decoded = try?JSONDecoder().decode([ExerciseApi].self, from: data){
                    DispatchQueue.main.async {
                        exercises = decoded
                        print(exercises.first?.name)
                        if let encoded = try? JSONEncoder().encode(exercises){
                            UserDefaults.standard.set(encoded, forKey: saveKeyExercises)
                        }
                    }
                    
                }
            }.resume()
            
        }
        completion(exercises.filter{$0.bodyPart == bodyPart})
    }
}
