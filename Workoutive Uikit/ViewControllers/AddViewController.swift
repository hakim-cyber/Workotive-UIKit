//
//  AddViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/8/23.
//

import UIKit

class AddViewController: UIViewController, UITableViewDelegate {
    private lazy var vm = AddDayVM()
    var newDays:(Day)->Void = {_ in }
    

    
    func bind(callBack: @escaping (Day)->Void){
        newDays = callBack
    }
    func setupViewModel(days:[Day]){
        self.vm.setup(days: days)
        
    }
    lazy var datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
       
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    lazy var segmentedControl:UISegmentedControl = {
        
        let items = self.vm.availibleDays.map{int in
            
                switch int {
                case 1:
                    return "Mon"
                case 2:
                    return "Tue"
                case 3:
                    return "Wed"
                case 4:
                    return "Thu"
                case 5:
                    return "Fri"
                case 6:
                    return "Sat"
                default:
                    return "Sun"
                }
            
           
        }
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(suitDidChange), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentTintColor = .openGreen
        segmentedControl.apportionsSegmentWidthsByContent = false
        let atributeBlack =  [NSAttributedString.Key.foregroundColor: UIColor.black]
       
        
        segmentedControl.setTitleTextAttributes(atributeBlack , for: .selected)
      
      
    
        
        return segmentedControl
    }()
    @objc func suitDidChange(_ sgmtedControl:UISegmentedControl){
        let index = sgmtedControl.selectedSegmentIndex
        
        self.vm.pickedNewDay = self.vm.availibleDays[index]
        
        
    }
    private lazy var addButton:UIButton = {
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Add Day", for: .normal)
        btn.setTitleColor(.openGreen, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
       
        return btn
    }()
    
    private lazy var newDayPicker:UIPickerView = {
        let picker = UIPickerView()
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return picker
    }()
    private lazy var containerView:UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.secondaryLabel.withAlphaComponent(0.05)
        return view
        
    }()
   
    private lazy var doneBtnView:UIButton = {
        let btn = UIButton()
       
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Done", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.sizeToFit()
        btn.titleLabel?.font = .systemFont(ofSize: 17,weight: .bold)
       
        return btn
    }()
    private lazy var daysOfWeek:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: UIScreen.main.bounds.width / 29, weight: .medium)
               lbl.textColor = .openGreen
               lbl.numberOfLines = 1
        lbl.text = "DAY OF WEEK"
        
        return lbl
    }()
    private lazy var reminderLabel:UILabel = {
        let reminderLabel = UILabel()
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.font = .systemFont(ofSize: UIScreen.main.bounds.width / 24, weight: .medium)
        reminderLabel.textColor = .openGreen
        reminderLabel.numberOfLines = 1
        reminderLabel.text = "Reminder"
        
        return reminderLabel
    }()
    
    private lazy var stackOfAll:UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var daysTableView:UITableView = {
        let tv = UITableView()
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = UIScreen.main.bounds.height / 22
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.allowsSelection = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "daysTableViewCell")
       
       
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        print(self.vm.days.count)
       
        setup()
        
        
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); DispatchQueue.main.async { self.daysTableView.reloadData() }}
    

    @objc func addBtnTapped(){
        
       if self.vm.availibleDays.count > 0 {
            let day = Day(id: self.vm.pickedNewDay, muscles: [])
           
           if let index = vm.availibleDays.firstIndex(where: {$0 == vm.pickedNewDay}){
               self.segmentedControl.removeSegment(at: index, animated: true)
           }
            
            self.newDays(day)
           self.vm.addedDay(day: day)
           if self.vm.availibleDays.count > 0{
               segmentedControl.selectedSegmentIndex = 0
               
               
           }
          viewWillAppear(true)
           
           
          
          
           if self.vm.availibleDays.isEmpty{
            
              
               self.segmentedControl.isHidden = true
               self.reminderLabel.isHidden = true
               self.datePicker.isHidden = true
               self.addButton.isHidden = true
              
           }
          
           
            
       }
        
        
    }
    @objc func doneBtnTapped(){
        
        self.dismiss(animated: true)
        
       
    }

}

extension AddViewController{
    func setup(){
        doneBtnView.addTarget(self, action: #selector(doneBtnTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        
        daysTableView.dataSource = self
       
        daysTableView.delegate = self
        
        let estimatedHeightTableView = self.vm.days.count
       
        
      
        self.view.addSubview(doneBtnView)
        self.view.addSubview(containerView)
        
        self.view.addSubview(daysOfWeek)
        self.containerView.addSubview(stackOfAll)
        
        if vm.availibleDays.count > 0{
            stackOfAll.addArrangedSubview(segmentedControl)
            stackOfAll.addArrangedSubview(reminderLabel)
            stackOfAll.addArrangedSubview(datePicker)
            stackOfAll.addArrangedSubview(addButton)
        }
        stackOfAll.addArrangedSubview(daysTableView)
       
        addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive =  vm.availibleDays.count > 0
        if vm.availibleDays.count > 0{
            daysTableView.topAnchor.constraint(equalTo: self.addButton.bottomAnchor,constant: 10).isActive = true
        }else{
            daysTableView.topAnchor.constraint(equalTo: self.stackOfAll.topAnchor,constant: 10).isActive = true
        }
       
        NSLayoutConstraint.activate([
            
            
           
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.12),
           
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: self.view.bounds.height / 9),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            daysOfWeek.bottomAnchor.constraint(equalTo: self.containerView.topAnchor, constant: -8),
            daysOfWeek.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            
            stackOfAll.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            stackOfAll.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            stackOfAll.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            stackOfAll.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            
            daysTableView.heightAnchor.constraint(equalToConstant: CGFloat(estimatedHeightTableView * Int(self.view.bounds.height) / 22)),
            daysTableView.bottomAnchor.constraint(equalTo: self.stackOfAll.bottomAnchor),
            daysTableView.leadingAnchor.constraint(equalTo: self.stackOfAll.leadingAnchor),
            daysTableView.trailingAnchor.constraint(equalTo: self.stackOfAll.trailingAnchor),
            
          
              
            
            
            doneBtnView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 10),
            doneBtnView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
       
    }
   
    
}



extension AddViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = self.vm.days[indexPath.row]
        
        let cell = daysTableView.dequeueReusableCell(withIdentifier: "daysTableViewCell",for: indexPath)
        let label = UILabel()
        switch day.id{
        case 1:
            cell.textLabel?.text = "Monday"
        case 2:
            cell.textLabel?.text = "Tuesday"
        case 3:
            cell.textLabel?.text = "Wednesday"
        case 4:
            cell.textLabel?.text = "Thursday"
        case 5:
            cell.textLabel?.text = "Friday"
        case 6:
            cell.textLabel?.text = "Saturday"
        default:
            cell.textLabel?.text = "Sunday"
        }
        cell.textLabel?.textColor = .openGreen
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont.systemFont(ofSize:  UIScreen.main.bounds.width / 24, weight: .medium)
        cell.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 20).isActive = true
        cell.textLabel?.textAlignment = .left
        cell.layoutIfNeeded()
              return cell
      
    }


}
