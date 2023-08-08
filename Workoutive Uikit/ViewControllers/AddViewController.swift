//
//  AddViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/8/23.
//

import UIKit

class AddViewController: UIViewController {
    
    private lazy var testButton:UIButton = {
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Test", for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setup()
        
        
        // Do any additional setup after loading the view.
        
    }
    

    @objc func testBtnTapped(){
        dismiss(animated: true)
    }

}

extension AddViewController{
    func setup(){
        testButton.addTarget(self, action: #selector(testBtnTapped), for: .touchUpInside)
        
        self.view.addSubview(testButton)
        
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        
        ])
    }
}
