//
//  ExerciseViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/15/23.
//

import UIKit

class ExerciseViewController: UIViewController {

    var selectedMuscle:Muscle?
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        setup()
        setupNavigationHeader()
    }
    func setup(){
       
     
      
        NSLayoutConstraint.activate([
           
            
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
        
    }
    

    

}
