//
//  AddViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/8/23.
//

import UIKit

class AddViewController: UIViewController {
    private lazy var vm = AddDayVM()
    var newDays:([Day])->Void = {_ in }
    
    
    
    func bind(callBack: @escaping ([Day])->Void){
        newDays = callBack
    }
    func setupViewModel(days:[Day]){
        self.vm.setup(days: days)
        
    }
    
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
        view.layer.cornerRadius = 10
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
    
    private lazy var stackOfAddedDays:UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentIndex = 0
       
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
    
        
        
        self.view.addSubview(containerView)
        self.view.addSubview(doneBtnView)
        self.view.addSubview(segmentedControl)
        
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.12),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
           
            segmentedControl.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -15),
            segmentedControl.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor , constant: 15),
            segmentedControl.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            
            doneBtnView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 10),
            doneBtnView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
    }
    
}
