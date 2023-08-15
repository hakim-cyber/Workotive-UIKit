//
//  ViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/12/23.
//

import UIKit


enum MuscleViewEvents{
    case newMuscle(Muscle)
    case deleteMuscle(Muscle)
}

class MuscleViewController: UIViewController {
    // Data
    
    var selectedDay:Day?
    var onEvent:(MuscleViewEvents)->Void = {_ in }
   
   
    
    func bind(callBack: @escaping (MuscleViewEvents)->Void){
            onEvent = callBack
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
            
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 15
        view.isUserInteractionEnabled = true
        
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
   
    private lazy var musclesTableView:UITableView = {
        let tv = UITableView()
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = UIScreen.main.bounds.height / 6
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.allowsSelection = true
        tv.register(MuscleTableViewCell.self, forCellReuseIdentifier: MuscleTableViewCell.cellId)
        tv.dataSource = self
        tv.delegate = self
        tv.isScrollEnabled = true
        
        return tv
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
        self.view.addSubview(musclesTableView)
        addViewContainer.addSubview(musclePicker)
        addViewContainer.addSubview(addMuscleButton)
        
        self.view.bringSubviewToFront(addViewContainer)
        
        
        self.addViewContainer.isHidden = true
        self.musclePicker.isHidden = true
        self.addMuscleButton.isHidden = true
        
        self.musclesTableView.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 35,right: 0)
    
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
            
            musclesTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            musclesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            musclesTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            musclesTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
            
           
            
        ])
    }
    func setupNavigationHeader(){
        let btnAdd = UIBarButtonItem(image:  UIImage(systemName: "plus.circle")  , style: .done, target: self, action: #selector(showAddViewTapped))
        
        let btnPlay =  UIBarButtonItem(image: UIImage(systemName: "play.circle"), style: .done, target: self, action: #selector(playButtonTapped))
        btnAdd.tintColor = .openGreen
        btnPlay.tintColor = .openGreen
        
        
        navigationItem.setRightBarButtonItems([btnAdd,btnPlay], animated: true)
        navigationController?.navigationBar.barTintColor = .clear
    }

    
    
    
    // Button Actions
    @objc func showAddViewTapped(){
        if addViewContainer.isHidden{
            openAddView()
        }else{
            closeAddView()
        }
    }
    func openAddView(){
        self.addViewContainer.hideWithAnimation(hidden: false)
        self.musclePicker.hideWithAnimation(hidden: false)
        self.addMuscleButton.hideWithAnimation(hidden: false)
    }
    func closeAddView(){
        // close
        self.addViewContainer.hideWithAnimation(hidden: true)
        self.musclePicker.hideWithAnimation(hidden: true)
        self.addMuscleButton.hideWithAnimation(hidden: true)
    }
    @objc func addMuscleButtonTapped(){
        if muscles.count > 0{
            let muscleId = self.muscles[musclePicker.selectedRow(inComponent: 0)]
            let muscle = Muscle(muscle: muscleId, exercises: [])
            
            self.onEvent(MuscleViewEvents.newMuscle(muscle))
            
            closeAddView()
        }
    }
    func filterMuscles(){
        self.muscles =   self.muscles.filter{mscl in
            return !(self.selectedDay?.muscles.contains(where: {$0.muscle == mscl}))!
        }
        musclePicker.reloadAllComponents()
        self.musclesTableView.reloadData()
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


extension MuscleViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDay?.muscles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MuscleTableViewCell.cellId, for: indexPath) as! MuscleTableViewCell
        cell.selectionStyle = .none
        cell.userInteractionEnabledWhileDragging = true
        cell.isUserInteractionEnabled = true
        cell.backgroundColor = .clear
        if let muscle = selectedDay?.muscles[indexPath.row]{
            cell.configure(muscle: muscle )
            
        }
       
              return cell
       
             
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            print("selected")
        
        let vc = ExerciseViewController()
        
        vc.selectedMuscle = self.selectedDay?.muscles[indexPath.row]
        
        vc.loadExercises {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
       
        
         
        
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { action, voew, completHandler in
            print("Delete \(indexPath.row)")
            
            
            if let muscle = self.selectedDay?.muscles[indexPath.row]{
                
                self.onEvent(MuscleViewEvents.deleteMuscle(muscle))
            }
            
            completHandler(true)
        }
        delete.backgroundColor = .black
        delete.image = UIImage(systemName: "trash.fill")
        
    
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
