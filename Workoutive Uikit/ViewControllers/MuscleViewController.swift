//
//  ViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/12/23.
//

import UIKit

class MuscleViewController: UIViewController {
    // Data
    
    var selectedDay:Day?
    var newMuscle:(Muscle)->Void = {_ in }
    
    func bind(callBack: @escaping (Muscle)->Void){
            newMuscle = callBack
        }
    
    var muscles:[String] = ["back",
                            "cardio",
                            "chest",
                            "lower arms",
                            "lower legs",
                            "neck",
                            "shoulders",
                            "upper arms",
                            "upper legs",
                            "waist"]
    // Setup VIews
    private lazy var musclePicker:UIPickerView = {
        let pck = UIPickerView()
        
        
        pck.translatesAutoresizingMaskIntoConstraints = false
        pck.dataSource = self
        pck.delegate = self
        pck.tintColor = .openGreen
        pck.layer.backgroundColor = UIColor.clear.cgColor
       
        
        
        return pck
    }()
    private lazy var addViewContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
            
        view.backgroundColor = UIColor.secondaryLabel.withAlphaComponent(0.2)
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var addMuscleButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add Muscle", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.backgroundColor = .openGreen
        btn.layer.cornerRadius = 15
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(self, action: #selector(addMuscleButtonTapped), for: .touchUpInside)
        return btn
    }()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark   
        self.view.backgroundColor = .systemBackground
                setup()
        setupNavigationHeader()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
       
       setupAddingView()
      
        NSLayoutConstraint.activate([
           
            
        ])
       
    }
    func setupAddingView(){
        self.view.addSubview(addViewContainer)
        addViewContainer.addSubview(musclePicker)
        addViewContainer.addSubview(addMuscleButton)
        
        self.addViewContainer.isHidden = true
        self.musclePicker.isHidden = true
        self.addMuscleButton.isHidden = true
    
        NSLayoutConstraint.activate([
            
            addViewContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            addViewContainer.trailingAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            addViewContainer.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.35),
            addViewContainer.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.23),
            
            addMuscleButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.35),
            addMuscleButton.heightAnchor.constraint(equalToConstant:   30),
            addMuscleButton.centerXAnchor.constraint(equalTo: addViewContainer.centerXAnchor),
            addMuscleButton.bottomAnchor.constraint(equalTo: addViewContainer.bottomAnchor),
            
            
            musclePicker.widthAnchor.constraint(equalToConstant:  self.view.bounds.width * 0.33),
            musclePicker.heightAnchor.constraint(equalToConstant:   self.view.bounds.height * 0.18),
            musclePicker.centerXAnchor.constraint(equalTo: self.addViewContainer.centerXAnchor),
            musclePicker.topAnchor.constraint(equalTo: self.addViewContainer.safeAreaLayoutGuide.topAnchor),
            musclePicker.bottomAnchor.constraint(equalTo: self.addMuscleButton.topAnchor,constant: -8),
            
           
            
        ])
    }
    func setupNavigationHeader(){
        let btnAdd = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(showAddViewTapped))
        
        let btnPlay =  UIBarButtonItem(image: UIImage(systemName: "play.circle"), style: .done, target: self, action: #selector(playButtonTapped))
        btnAdd.tintColor = .openGreen
        btnPlay.tintColor = .openGreen
        
        
        navigationItem.setRightBarButtonItems([btnAdd,btnPlay], animated: true)
        
    }

    
    
    
    // Button Actions
    @objc func showAddViewTapped(){
        if self.addViewContainer.isHidden == true{
            self.addViewContainer.hideWithAnimation(hidden: false)
            self.musclePicker.hideWithAnimation(hidden: false)
            self.addMuscleButton.hideWithAnimation(hidden: false)
        }else{
            // close
            self.addViewContainer.hideWithAnimation(hidden: true)
            self.musclePicker.hideWithAnimation(hidden: true)
            self.addMuscleButton.hideWithAnimation(hidden: true)
        }
    }
    @objc func addMuscleButtonTapped(){
        if muscles.count > 0{
            let muscleId = self.muscles[musclePicker.selectedRow(inComponent: 0)]
            let muscle = Muscle(muscle: muscleId, exercises: [])
            
            self.newMuscle(muscle)
        }
    }
    func filterMuscles(){
        self.muscles =   self.muscles.filter{mscl in
            return !(self.selectedDay?.muscles.contains(where: {$0.muscle == mscl}))!
        }
        musclePicker.reloadAllComponents()
    }
    @objc func playButtonTapped(){
        
    }
}

extension MuscleViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return muscles.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .openGreen
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        label.text = muscles[row].capitalized
        
       
        return label
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return  self.view.bounds.width * 0.35
    }
}



extension UIView {
func hideWithAnimation(hidden: Bool) {
    UIView.transition(with: self, duration: 0.4, options:  .transitionFlipFromRight, animations: {
            self.isHidden = hidden
        })
    
    }
}
