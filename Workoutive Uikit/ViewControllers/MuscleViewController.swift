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
    
    let muscles:[String] = ["Back","Chest","Biceps","Triceps","Core","Legs"]
    // Setup Actions
    private lazy var picker:UIPickerView = {
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
        view.backgroundColor = UIColor.secondaryLabel.withAlphaComponent(0.05)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        setup()
        setupNavigationHeader()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
       
        self.view.addSubview(picker)
      
        NSLayoutConstraint.activate([
            picker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            picker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            picker.widthAnchor.constraint(equalToConstant: 100),
            
        ])
       
    }
    func setupNavigationHeader(){
        let btnAdd = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(addButtonTapped))
        
        let btnPlay =  UIBarButtonItem(image: UIImage(systemName: "play.circle"), style: .done, target: self, action: #selector(playButtonTapped))
        btnAdd.tintColor = .openGreen
        btnPlay.tintColor = .openGreen
        
        
        navigationItem.setRightBarButtonItems([btnAdd,btnPlay], animated: true)
        
    }

    
    
    
    // Button Actions
    @objc func addButtonTapped(){
        
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
        
        label.text = muscles[row]
        
       
        return label
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
}
