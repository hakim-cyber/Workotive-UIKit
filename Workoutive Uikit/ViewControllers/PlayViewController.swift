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
    private lazy var playButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .bold, scale: .default)
               
        let largeBoldX = UIImage(systemName: "play.circle", withConfiguration: largeConfig)

        
        btn.setImage(largeBoldX, for: .normal)
        btn.tintColor = .openGreen
        btn.addTarget(self, action: #selector(playBtnTapped), for: .touchUpInside)
        
        
        return btn
    }()
    private lazy var controlContainerView:UIView = {
        let vw = UIView()
        
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .black
        vw.layer.cornerCurve = .continuous
        vw.layer.cornerRadius = 15
        
        return vw
    }()
    private lazy var informationContainerView:UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .openGreen
        vw.layer.cornerCurve = .continuous
        vw.layer.cornerRadius = 15
        return vw
    }()
    
    func setup(){
        setupNavigationHeader()
        
        self.view.addSubview(controlContainerView)
        self.controlContainerView.addSubview(informationContainerView)
        self.controlContainerView.addSubview(playButton)
        NSLayoutConstraint.activate([
            controlContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: 15),
            controlContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            controlContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),     
            controlContainerView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 2.4),
            
            informationContainerView.topAnchor.constraint(equalTo: self.controlContainerView.topAnchor,constant: 10),
            informationContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -25),
            informationContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 25),
            informationContainerView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 2.4 / 4),
            
            playButton.bottomAnchor.constraint(equalTo: self.controlContainerView.bottomAnchor, constant: -50),
            playButton.centerXAnchor.constraint(equalTo: self.controlContainerView.centerXAnchor),
        ])
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
    @objc func playBtnTapped(){
        
    }
}