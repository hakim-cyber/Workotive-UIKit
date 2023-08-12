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
    
    
    // Setup Actions
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setup()
        setupNavigationHeader()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        let label = UILabel()
        label.text = "\(String(describing: selectedDay?.id))"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
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
