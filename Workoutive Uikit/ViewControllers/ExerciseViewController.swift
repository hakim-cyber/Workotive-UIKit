//
//  ExerciseViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/15/23.
//

import UIKit
enum ExerciseViewEvents{
    case new(ExerciseApi)
    case delete(ExerciseApi)
}

class ExerciseViewController: UIViewController {

    var selectedMuscle:Muscle?
    var onEvent:(ExerciseViewEvents)->Void = {_ in }
   
   
    
    func bind(callBack: @escaping (ExerciseViewEvents)->Void){
            onEvent = callBack
        }
    // Views
    var newExerciseReps = 0
    var newExerciseSets = 0
    var exercises = [ExerciseApi]()
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
        pck.tag = 1
        
        
        return pck
    }()
    @objc private lazy var setsandRepsPicker:UIPickerView = {
        let pck = UIPickerView()
        
        pck.largeContentTitle = "Picker"
        pck.translatesAutoresizingMaskIntoConstraints = false
        
       
        pck.tintColor = .openGreen
        pck.layer.backgroundColor = UIColor.clear.cgColor
        pck.delegate = self
        pck.dataSource = self
        pck.tag = 2
        
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
    private lazy var setsAndRepsTextField:UITextField = {
        let tf = UITextField()
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(string: "Sets And Reps",attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold)])
        tf.textAlignment = .center
        
        tf.font = .systemFont(ofSize: 15, weight: .bold)
        tf.adjustsFontSizeToFitWidth = true
        tf.backgroundColor = .darkGray
        tf.borderStyle = .none
       
        tf.textColor = .white
      
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        return tf
    }()
   
    private lazy var exerciseTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(string: "Select Exercise",attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold)])
        tf.textAlignment = .center
        
        tf.font = .systemFont(ofSize: 15, weight: .bold)
        tf.adjustsFontSizeToFitWidth = true
        tf.backgroundColor = .darkGray
        tf.borderStyle = .none
       
        tf.textColor = .white
      
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        return tf
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
        tv.allowsSelection = false
        tv.isScrollEnabled = true
        tv.register(ExerciseTableViewCell.self, forCellReuseIdentifier: ExerciseTableViewCell.cellId)
        tv.dataSource = self
        tv.delegate = self
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
       
       
       
        
       
        self.view.addSubview(exercisesTableView)
        
        self.exercisesTableView.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 35,right: 0)
        NSLayoutConstraint.activate([
            exercisesTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            exercisesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            exercisesTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            exercisesTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        setupAddView()
       
    }
    let dm = DataManager()
    
    func loadExercises(complete:@escaping ()->Void){
        
            dm.loadAllExcercises(for: self.selectedMuscle!.muscle) { exercises in
                
                self.exercises = exercises.filter { exercise in
                    let containsExercise = self.selectedMuscle?.exercises.contains { selectedExercise in
                        return selectedExercise.id == exercise.id
                    }
                   
                    return containsExercise == false
                }
                
                if self.exercises.count > 0{
                    complete()
                }
                
            }
           
        
    }
    func refreshAllData(){
        self.exercises = exercises.filter { exercise in
            let containsExercise = self.selectedMuscle?.exercises.contains { selectedExercise in
                return selectedExercise.id == exercise.id
            }
           
            return containsExercise == false
        }
        self.exercisesTableView.reloadData()
        self.exercisePicker.reloadAllComponents()
    }
    func setupAddView(){
        self.view.addSubview(addViewContainer)
        self.addViewContainer.addSubview(addExerciseButton)
        self.addViewContainer.addSubview(exerciseTextField)
        self.addViewContainer.addSubview(setsAndRepsTextField)
        self.view.bringSubviewToFront(addViewContainer)
        
        self.addViewContainer.isHidden = true
        
        
        exerciseTextField.inputView = exercisePicker
        setsAndRepsTextField.inputView = setsandRepsPicker
       
        
       
        let toolbar1 = UIToolbar()
          toolbar1.sizeToFit()
          let doneButton1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(exercisePickerDoneButtonTapped))
          toolbar1.setItems([doneButton1], animated: false)
          exerciseTextField.inputAccessoryView = toolbar1
        
        let toolbar2 = UIToolbar()
          toolbar2.sizeToFit()
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setsAndRepsPickerDoneButtonTapped))
          toolbar2.setItems([doneButton2], animated: false)
          setsAndRepsTextField.inputAccessoryView = toolbar2
        
        
        NSLayoutConstraint.activate([
            addViewContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            addViewContainer.trailingAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            addViewContainer.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.55),
            addViewContainer.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.2),
            
            addExerciseButton.widthAnchor.constraint(equalToConstant:self.view.bounds.width * 0.55),
            addExerciseButton.heightAnchor.constraint(equalToConstant:   30),
            addExerciseButton.centerXAnchor.constraint(equalTo: addViewContainer.centerXAnchor),
            addExerciseButton.bottomAnchor.constraint(equalTo: addViewContainer.bottomAnchor),
            
            exerciseTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.5),
            exerciseTextField.heightAnchor.constraint(equalToConstant: 33),
           
            exerciseTextField.centerXAnchor.constraint(equalTo: self.addViewContainer.centerXAnchor),
            exerciseTextField.topAnchor.constraint(equalTo: self.addViewContainer.topAnchor,constant: 20),
            
            setsAndRepsTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.5),
            setsAndRepsTextField.heightAnchor.constraint(equalToConstant: 33),
           
            setsAndRepsTextField.centerXAnchor.constraint(equalTo: self.addViewContainer.centerXAnchor),
            setsAndRepsTextField.topAnchor.constraint(equalTo: self.exerciseTextField.bottomAnchor,constant: 20),
            
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
        if self.newExerciseSets != 0 && self.newExerciseReps != 0 &&  self.exerciseTextField.text != nil{
            var newExercise = exercises[self.exercisePicker.selectedRow(inComponent: 0)]
            newExercise.sets = self.newExerciseSets
            newExercise.repeatCount = self.newExerciseReps
            
            self.onEvent(.new(newExercise))
            
            closeAddView()
            self.newExerciseReps = 0
            self.newExerciseSets = 0
            self.setsAndRepsTextField.text = "\(self.newExerciseSets) sets x \(self.newExerciseReps) reps"
            self.exerciseTextField.text = nil
            self.exercisePicker.selectRow(0, inComponent: 0, animated: true)
        }
     
    }
    
    @objc func exercisePickerDoneButtonTapped() {
        exerciseTextField.resignFirstResponder()
       
        // Dismiss the picker
    }
    @objc func setsAndRepsPickerDoneButtonTapped() {
        setsAndRepsTextField.resignFirstResponder()
       
        // Dismiss the picker
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
        if pickerView.tag == 1{
            return 1
        }else {
            return 4
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return exercises.count
        }else{
            if component == 0{
                return 1
            }else if component == 1{
                return 8
            }else if component == 2{
                return 1
            }else{
                return 20
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .openGreen
        
            if component == 1 || component == 3 {
                label.font = .systemFont(ofSize: 16, weight: .bold)
            }else if component == 0{
                label.font = .systemFont(ofSize: 20, weight: .black)
            }else if component == 2{
                label.font = .systemFont(ofSize: 20, weight: .black)
            }
        
        if pickerView.tag == 1{
            label.text = exercises[row].name.capitalized
        }else{
            if component == 1 || component == 3 {
                label.text =  "\(row + 1)"
            }else if component == 0{
                label.text = "Sets :"
            }else if component == 2{
                label.text = "Reps :"
            }
        }
        
       
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            exerciseTextField.text = exercises[row].name.capitalized
            exerciseTextField.resignFirstResponder()
        }else{
            if component == 1{
                self.newExerciseSets = row + 1
            }else if component == 3{
                self.newExerciseReps = row + 1
                
            }
            self.setsAndRepsTextField.text = "\(self.newExerciseSets) sets x \(self.newExerciseReps) reps"
            
            
        }
    }
    
   
}


extension ExerciseViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMuscle?.exercises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.cellId, for: indexPath) as! ExerciseTableViewCell
        cell.selectionStyle = .none
        cell.userInteractionEnabledWhileDragging = true
        cell.isUserInteractionEnabled = true
        cell.backgroundColor = .clear
        if let exercise = selectedMuscle?.exercises[indexPath.row]{
            cell.configure(exercise:  exercise )
            
        }
       
              return cell
       
             
      
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { action, voew, completHandler in
            print("Delete \(indexPath.row)")
            
            
            if let exercise = self.selectedMuscle?.exercises[indexPath.row]{
               // delete
                self.onEvent(.delete(exercise))
            }
            
            completHandler(true)
        }
        delete.backgroundColor = .black
        delete.image = UIImage(systemName: "trash.fill")
        
    
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
