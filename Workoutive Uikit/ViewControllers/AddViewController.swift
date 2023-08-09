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
       
        
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.12),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
           
            
            doneBtnView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 10),
            doneBtnView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
    }
    
}
