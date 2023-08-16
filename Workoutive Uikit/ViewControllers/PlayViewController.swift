//
//  PlayViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/17/23.
//

import UIKit

class PlayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .openGreen
        setup()
        
        // Do any additional setup after loading the view.
    }
    private lazy var backBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .default)
               
        let largeBoldX = UIImage(systemName: "xmark", withConfiguration: largeConfig)

        
        btn.setImage(largeBoldX, for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        
        return btn
    }()
    
    func setup(){
        setupNavigationHeader()
        
    }
    func setupNavigationHeader(){
        
        self.view.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
           
            backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 27)
        
        ])
    }
    
    
    //Buttons
    @objc func backButtonTapped(){
        self.dismiss(animated: true)
    }
}
