//
//  ExerciseViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/15/23.
//

import UIKit

class ExerciseViewController: UIViewController {

    var selectedMuscle:Muscle?
    // Views
    let workoutExercises = [
        "Push-ups",
        "Sit-ups",
        "Squats",
        "Lunges",
        "Plank",
        "Burpees",
        "Jumping Jacks",
        "Mountain Climbers",
        "Bicep Curls",
        "Tricep Dips"
    ]
    private lazy var exercisePicker:UIPickerView = {
        let pck = UIPickerView()
        
        
        pck.translatesAutoresizingMaskIntoConstraints = false
       
        pck.tintColor = .openGreen
        pck.layer.backgroundColor = UIColor.clear.cgColor
        pck.delegate = self
        pck.dataSource = self
    
        
        return pck
    }()
    
    private lazy var addViewContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
            
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 15
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var addExerciseButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add Exercise", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.backgroundColor = .openGreen
        btn.layer.cornerRadius = 15
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(self, action: #selector(addExerciseButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var exercisesTableView:UITableView = {
        let tv = UITableView()
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = UIScreen.main.bounds.height / 7
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.allowsSelection = true
        tv.isScrollEnabled = true
        
        return tv
    }()
    
    
    // Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        setup()
        setupNavigationHeader()
    }
    func setup(){
       
        setupAddView()
      
        NSLayoutConstraint.activate([
           
            
        ])
       
    }
    func setupAddView(){
        self.view.addSubview(addViewContainer)
        addViewContainer.addSubview(addExerciseButton)
        addViewContainer.addSubview(exercisePicker)
        
        self.view.bringSubviewToFront(addViewContainer)
        
        self.addViewContainer.isHidden = true
       
        
        
        NSLayoutConstraint.activate([
            addViewContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            addViewContainer.trailingAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            addViewContainer.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.55),
            addViewContainer.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.28),
            
            addExerciseButton.widthAnchor.constraint(equalToConstant:self.view.bounds.width * 0.55),
            addExerciseButton.heightAnchor.constraint(equalToConstant:   30),
            addExerciseButton.centerXAnchor.constraint(equalTo: addViewContainer.centerXAnchor),
            addExerciseButton.bottomAnchor.constraint(equalTo: addViewContainer.bottomAnchor),
            
            exercisePicker.widthAnchor.constraint(equalToConstant:  self.view.bounds.width * 0.50),
            exercisePicker.heightAnchor.constraint(equalToConstant:   self.view.bounds.height * 0.12),
            exercisePicker.centerXAnchor.constraint(equalTo: self.addViewContainer.centerXAnchor),
            exercisePicker.topAnchor.constraint(equalTo: self.addViewContainer.safeAreaLayoutGuide.topAnchor),
            exercisePicker.bottomAnchor.constraint(equalTo: self.addExerciseButton.topAnchor,constant: -8),
            
        ])
    
    }
    func setupNavigationHeader(){
        let btnAdd = UIBarButtonItem(image:  UIImage(systemName: "plus.circle")  , style: .done, target: self, action: #selector(showAddViewTapped))
        
       
        btnAdd.tintColor = .openGreen
       
        
        
        navigationItem.setRightBarButtonItems([btnAdd], animated: true)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = self.selectedMuscle?.muscle.capitalized
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    @objc func showAddViewTapped(){
        if addViewContainer.isHidden{
            openAddView()
        }else{
            closeAddView()
        }
    }
    @objc func addExerciseButtonTapped(){
       
    }
    func openAddView(){
        self.addViewContainer.hideWithAnimation(hidden: false)
      
    }
    func closeAddView(){
        // close
        self.addViewContainer.hideWithAnimation(hidden: true)
       
    }

    

}

extension ExerciseViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workoutExercises.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .openGreen
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        label.text = workoutExercises[row]
        
       
        return label
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return  self.view.bounds.width * 0.5
    }
}
