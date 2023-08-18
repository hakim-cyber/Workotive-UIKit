//
//  PlayViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/17/23.
//

import UIKit

class PlayViewController: UIViewController {
    
    var day:Day?
    
    var excercisesIndex = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .openGreen
        setup()
        
        // Do any additional setup after loading the view.
    }
    private lazy var backBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .default)
               
        let largeBoldX = UIImage(systemName: "xmark", withConfiguration: largeConfig)

        
        btn.setImage(largeBoldX, for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        
        return btn
    }()
    
    private lazy var playButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .bold, scale: .default)
               
        let largeBoldX = UIImage(systemName: "play.circle", withConfiguration: largeConfig)

        
        btn.setImage(largeBoldX, for: .normal)
        btn.tintColor = .openGreen
        btn.addTarget(self, action: #selector(playBtnTapped), for: .touchUpInside)
        
        
        return btn
    }()
    private lazy var controlContainerView:UIView = {
        let vw = UIView()
        
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .black
        vw.layer.cornerCurve = .continuous
        vw.layer.cornerRadius = 15
        
        return vw
    }()
    private lazy var informationContainerView:UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .openGreen
        vw.layer.cornerCurve = .continuous
        vw.layer.cornerRadius = 15
        return vw
    }()
    private lazy var setsAndRepsText:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = .monospacedSystemFont(ofSize: 33, weight: .bold
        )
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.textColor = .black
        
        
        return lbl
    }()
    private lazy var currentExerciseText:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .monospacedSystemFont(ofSize: 38, weight: .bold)
        lbl.adjustsFontSizeToFitWidth = true
        
        lbl.textAlignment = .center
        lbl.textColor = .black
        
        
        return lbl
    }()
   
    
    func setup(){
        setupNavigationHeader()
        if allExcercises.count > excercisesIndex{
            let exercise = allExcercises[self.excercisesIndex]
            setsAndRepsText.text = "\(Int(exercise.sets!))x\(Int(exercise.repeatCount!))"
            currentExerciseText.text = "\(exercise.name.capitalized)"
        }
        self.view.addSubview(controlContainerView)
        self.view.addSubview(currentExerciseText)
        self.controlContainerView.addSubview(informationContainerView)
        self.controlContainerView.addSubview(playButton)
        self.informationContainerView.addSubview(setsAndRepsText)
        NSLayoutConstraint.activate([
            controlContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: 15),
            controlContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            controlContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),     
            controlContainerView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 2.4),
            
            informationContainerView.topAnchor.constraint(equalTo: self.controlContainerView.topAnchor,constant: 10),
            informationContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           
            informationContainerView.widthAnchor.constraint(equalToConstant: 150),
            informationContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            playButton.bottomAnchor.constraint(equalTo: self.controlContainerView.bottomAnchor, constant: -50),
            playButton.centerXAnchor.constraint(equalTo: self.controlContainerView.centerXAnchor),
            
            setsAndRepsText.centerYAnchor.constraint(equalTo: informationContainerView.centerYAnchor),
            setsAndRepsText.centerXAnchor.constraint(equalTo: informationContainerView.centerXAnchor),
            
                      currentExerciseText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            currentExerciseText.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -self.view.bounds.height / 4),
            currentExerciseText.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 1.1)
            
            
        ])
    }
    func setupNavigationHeader(){
        
        self.view.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
           
            backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 27)
        
        ])
    }
    var estimatedTimeForWorkout: Int{
        var setsCount = 0
        for muscle in day!.muscles {
            for excercise in muscle.exercises{
                setsCount += excercise.sets!
            }
        }
        
        let estimatedTime = setsCount * 120 + (setsCount - 1) * 120
        if estimatedTime > 0{
            return estimatedTime
        }else{
            return 0
        }
    }
    var allExcercises:[ExerciseApi]{
        let muscles = day!.muscles
        var excercises = [ExerciseApi]()
        for muscle in muscles {
            for excercise in muscle.exercises {
                excercises.append(excercise)
            }
        }
      
        return excercises
    }
    var muscleWorkingNowIndex:Int{
        if !day!.muscles.isEmpty && !allExcercises.isEmpty{
            return day!.muscles.firstIndex(where: {($0.exercises.contains(self.allExcercises[excercisesIndex]))}) ?? 0
        }else{
            return 0
        }
        
    }
    
    var estimatedCalories:String  {
        let estimatedInHours = Double(estimatedTimeForWorkout) / 3600
        return String(format: "%.1f", estimatedInHours * 300)
    }
    func nextExcercise(){
        let countOfExcercises = allExcercises.count
          
        if countOfExcercises != self.excercisesIndex + 1{
            self.excercisesIndex += 1
            let exercise = allExcercises[self.excercisesIndex]
            setsAndRepsText.text = "\(Int(exercise.sets!))x\(Int(exercise.repeatCount!))"
            currentExerciseText.text = "\(exercise.name.capitalized)"
        }else{
            // end
            
        }
        
    }
    var excercisesRemaining:Int{
        let all = allExcercises.count
        let nowOn = excercisesIndex + 1
        return all - nowOn
    }
    
    //Buttons
    @objc func backButtonTapped(){
        self.dismiss(animated: true)
    }
    @objc func playBtnTapped(){
        nextExcercise()
    }
}
