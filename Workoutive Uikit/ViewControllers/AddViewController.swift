//
//  AddViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/8/23.
//

import UIKit

class AddViewController: UIViewController, UITableViewDelegate {
    private lazy var vm = AddDayVM()
    var newDays:([Day])->Void = {_ in }
    
    
    
    func bind(callBack: @escaping ([Day])->Void){
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
        btn.titleLabel?.font = .systemFont(ofSize: 17,weight: .medium)
        
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
        view.backgroundColor = UIColor.secondaryLabel.withAlphaComponent(0.1)
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
    private lazy var selectedDayLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: UIScreen.main.bounds.width / 12, weight: .bold)
               lbl.textColor = .openGreen
               lbl.numberOfLines = 1
        
        return lbl
    }()
    
    private lazy var stackOfAll:UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var daysTableView:UITableView = {
        let tv = UITableView()
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
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
    

    @objc func addBtnTapped(){
        newDays([Day(id: 7, muscles: [])])
        
        
    }
    @objc func doneBtnTapped(){
        
        self.dismiss(animated: true)
        
       
    }

}

extension AddViewController{
    func setup(){
        doneBtnView.addTarget(self, action: #selector(doneBtnTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        
        selectedDayLabel.text = "Sunday"
        daysTableView.dataSource = self
       
        daysTableView.delegate = self
        
       
        self.view.addSubview(doneBtnView)
        self.view.addSubview(containerView)
       
        
        
        
        NSLayoutConstraint.activate([
           
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.12),
            containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1.62),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
           
           
            
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
            cell.textLabel?.text = "Mon"
        case 2:
            cell.textLabel?.text = "Tue"
        case 3:
            cell.textLabel?.text = "Wed"
        case 4:
            cell.textLabel?.text = "Th"
        case 5:
            cell.textLabel?.text = "Fri"
        case 6:
            cell.textLabel?.text = "Sat"
        default:
            cell.textLabel?.text = "Sun"
        }
        cell.textLabel?.textColor = .openGreen
        cell.backgroundColor = .clear
    
              return cell
      
    }
    
    

}
