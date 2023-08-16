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
    /*
    func updateDay(day:Day)async{
            guard let appdelegate = await UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = await appdelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CashedDay")
            fetchRequest.predicate = NSPredicate(format: "id = %d", Int16(day.id))


            do{
                
                var test = try managedContext.fetch(fetchRequest) as! [CashedDay]
                
              
                if test.count > 0{
                    
                    
                    
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
                    print(day)
                    test[0].muscle = arrayMuscles as NSSet
                    
                   
                    
                }
               
                do{
                    try managedContext.save()
                    print("saved \(test[0])")
                }catch{
                    print(error)
                }
                
            }catch{
                print(error)
            }
            
        }
       */
    func updateDay(day: Day) async {
        guard let appdelegate = await UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = await appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CashedDay")
        fetchRequest.predicate = NSPredicate(format: "id = %d", Int16(day.id))

        do {
            let cachedDays = try managedContext.fetch(fetchRequest) as! [CashedDay]

            if let cachedDay = cachedDays.first {
                var existingMuscles = cachedDay.muscle?.allObjects as? [CashedMuscle] ?? []
                var updatedMuscles = Set<CashedMuscle>()

                for muscle in day.muscles {
                    if let existingMuscle = existingMuscles.first(where: { $0.id == muscle.id }) {
                        // Update existing muscle properties
                        existingMuscle.muscle = muscle.muscle
                        existingMuscle.id = muscle.id

                        // Update exercises
                        var updatedExercises = Set<CashedExcercise>()

                        for exercise in muscle.exercises {
                            if let existingExercise = existingMuscle.exercise?.first(where: { ($0 as! CashedExcercise).id == exercise.id }) as? CashedExcercise {
                                // Update existing exercise properties
                                existingExercise.id = exercise.id
                                existingExercise.bodyPart = exercise.bodyPart
                                existingExercise.equipment = exercise.equipment
                                existingExercise.gifUrl = exercise.gifUrl
                                existingExercise.name = exercise.name
                                existingExercise.repeatsCount = Int16(exercise.repeatCount!)
                                existingExercise.setsCount = Int16(exercise.sets!)
                                existingExercise.target = exercise.target
                                // Update other exercise properties...

                                updatedExercises.insert(existingExercise)
                            }else{
                                let newExercise = CashedExcercise(context: managedContext)
                                newExercise.id = exercise.id
                                newExercise.bodyPart = exercise.bodyPart
                                newExercise.equipment = exercise.equipment
                                newExercise.gifUrl = exercise.gifUrl
                                newExercise.name = exercise.name
                                newExercise.repeatsCount = Int16(exercise.repeatCount!)
                                newExercise.setsCount = Int16(exercise.sets!)
                                newExercise.target = exercise.target
                                
                                updatedExercises.insert(newExercise)
                            }
                        }

                        existingMuscle.exercise = updatedExercises as NSSet
                        updatedMuscles.insert(existingMuscle)
                    } else {
                        let newMuscle = CashedMuscle(context: managedContext)
                        newMuscle.muscle = muscle.muscle
                        newMuscle.id = muscle.id

                        var arrayExcercise = Set<CashedExcercise>()

                        for exercise in muscle.exercises {
                            let newExercise = CashedExcercise(context: managedContext)
                            newExercise.id = exercise.id
                            newExercise.bodyPart = exercise.bodyPart
                            newExercise.equipment = exercise.equipment
                            newExercise.gifUrl = exercise.gifUrl
                            newExercise.name = exercise.name
                            newExercise.repeatsCount = Int16(exercise.repeatCount!)
                            newExercise.setsCount = Int16(exercise.sets!)
                            newExercise.target = exercise.target
                            // Set other exercise properties...

                            arrayExcercise.insert(newExercise)
                        }

                        newMuscle.exercise = arrayExcercise as NSSet
                        updatedMuscles.insert(newMuscle)
                    }
                }

                cachedDay.muscle = updatedMuscles as NSSet

                do {
                    try managedContext.save()
                    print("Data saved successfully.")
                } catch let error as NSError {
                    print("Error saving data: \(error), \(error.userInfo)")
                }
            }
        } catch {
            print(error)
        }
    }


    
    func deleteFromCoreData(id:Int)async{
        guard let appdelegate = await UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = await appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CashedDay")
        
        do{
            var test = try managedContext.fetch(fetchRequest)
            
            for data in test as! [CashedDay]{
                if Int(data.id) == id{
                    managedContext.delete(data)
                    
                    do{
                        try managedContext.save()
                    }catch{
                        print(error)
                    }
                }
            }
           
           
          
        }catch{
            print(error)
        }
    }
    func addDays(day:Day) async{
       
            self.days.append(day)
        
        await saveDay(day:day)
    }
    func removeDay(day:Day) {
       
        self.days.removeAll(where: {$0.id == day.id})
      
        Task{
            await deleteFromCoreData(id:day.id)
        }
    }
    func addMuscleTo(dayID:Int,muscle:Muscle)  {
        if let index = self.days.firstIndex(where: {$0.id == dayID}){
            if let indexOfExistingMuscle = self.days[index].muscles.firstIndex(where: {$0.id == muscle.id}){
                self.days[index].muscles[indexOfExistingMuscle] = muscle
                print("adding existing muscle")
                
            }else{
                self.days[index].muscles.append(muscle)
               
            }
            
            Task{
                print("\(self.days[index])")
                await updateDay(day: self.days[index])
            }
        }
    }
    func deleteMuscleAt(dayID:Int,muscle:Muscle) {
        if let index = self.days.firstIndex(where: {$0.id == dayID}){
            self.days[index].muscles.removeAll(where: {$0.id == muscle.id})
            Task{
                await updateDay(day: self.days[index])
            }
        
        }
    }
    func deleteExercise(muscleid:UUID,dayId:Int,exerciseID:String){
        
            guard let indexOfDay = self.days.firstIndex(where: { $0.id == dayId }),
                  let indexOfMuscle = self.days[indexOfDay].muscles.firstIndex(where: { $0.id == muscleid }) else {
                return // Exit if dayID or muscleID is not found
            }
            
            self.days[indexOfDay].muscles[indexOfMuscle].exercises.removeAll { $0.id == exerciseID }
        print("deleting in \(self.days[indexOfDay])")
            
            Task {
                await updateDay(day: self.days[indexOfDay])
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
