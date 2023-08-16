//
//  DataManager.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/7/23.
//

import UIKit
import CoreData


class DataManager:ObservableObject{
    private(set) var days:[Day] = []
     
 
    
    init() {
        loadDays()
    }
    func loadDays(){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CashedDay")
        
     
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [CashedDay]
            
            var daysArray:[Day] = []
            for cashed in result {
                let id = cashed.id
                let muscles = cashed.arrayOfMuscles
                
                var arrayOfmuscles:[Muscle] = []
                
                for muscle in muscles {
                    var arrayOfExercises:[ExerciseApi] = []
                    
                    for exercise in muscle.exerciseArray {
                        var newExercise = ExerciseApi(bodyPart: exercise.wrappedBodyPart, equipment: exercise.wrappedEquipment, gifUrl: exercise.wrappedGifUrl, id: exercise.id ?? "", name: exercise.wrappedName, target: exercise.wrappedTarget)
                        newExercise.repeatCount = Int(exercise.repeatsCount)
                        newExercise.sets = Int(exercise.setsCount)
                        
                        arrayOfExercises.append(newExercise)
                    }
                    let newMuscle = Muscle(id:muscle.id ?? UUID(),muscle: muscle.wrappedMuscle, exercises: arrayOfExercises)
                    
                    arrayOfmuscles.append(newMuscle)
                }
                let newDay = Day(id: Int(id), muscles: arrayOfmuscles)
                
                daysArray.append(newDay)
            }
            self.days = daysArray
            print("loaded")
            
            
        }catch{
            print(error)
        }
    }
    func saveDay(day:Day)async{
        guard let appdelegate = await UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = await appdelegate.persistentContainer.viewContext
     
        
        
                await MainActor.run {
                    
                        let newDay = CashedDay(context: managedContext)
                        newDay.id = Int16(day.id)
                        
                        var arrayMuscles = Set<CashedMuscle>()
                        
                        for muscle in day.muscles{
                            let newMuscle = CashedMuscle(context: managedContext)
                            newMuscle.muscle = muscle.muscle
                            newMuscle.id = muscle.id
                        
                            var arrayExcercise = Set<CashedExcercise>()
                            
                            for excercise in muscle.exercises{
                                let newExercise = CashedExcercise(context: managedContext)
                                newExercise.id = excercise.id
                                newExercise.bodyPart = excercise.bodyPart
                                newExercise.equipment = excercise.equipment
                                newExercise.gifUrl = excercise.gifUrl
                                newExercise.name = excercise.name
                                newExercise.repeatsCount = Int16(excercise.repeatCount!)
                                newExercise.setsCount = Int16(excercise.sets!)
                                newExercise.target = excercise.target
                                
                                arrayExcercise.insert(newExercise)
                            }
                            newMuscle.exercise = arrayExcercise as NSSet
                            
                            arrayMuscles.insert(newMuscle)
                        }
                        newDay.muscle = arrayMuscles as NSSet
                                   
                        do{
                            
                            try managedContext.save()
                        }catch{
                            print("\(error.localizedDescription)")
                        }
                    
                }
            
        
    }
    func addDays(day:Day) async{
       
            self.days.append(day)
        
        await saveDay(day:day)
    }
    func removeDay(day:Day) {
       
        self.days.removeAll(where: {$0.id == day.id})
      
        
    }
    func addMuscleTo(dayID:Int,muscle:Muscle)  {
        if let index = self.days.firstIndex(where: {$0.id == dayID}){
            if let indexOfExistingMuscle = self.days[index].muscles.firstIndex(where: {$0.id == muscle.id}){
                self.days[index].muscles[indexOfExistingMuscle] = muscle
                print("adding existing muscle")
            }else{
                self.days[index].muscles.append(muscle)
            }
           
        }
    }
    func deleteMuscleAt(dayID:Int,muscle:Muscle) {
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
                completion(exercises.filter{$0.bodyPart == bodyPart})
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
                        completion(exercises.filter{$0.bodyPart == bodyPart})
                        print(exercises.first?.name)
                        if let encoded = try? JSONEncoder().encode(exercises){
                            UserDefaults.standard.set(encoded, forKey: saveKeyExercises)
                        }
                    }
                    
                }
            }.resume()
            
        }
       
    }
}
