//
//  MuscleTableViewCell.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/14/23.
//

import UIKit

class MuscleTableViewCell: UITableViewCell {
    static let cellId = "MuscleTableViewCell"
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    private lazy var trashBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .red
        
        return btn
    }()
    private lazy var arrowImage:UIImageView = {
            let imgView = UIImageView()
            
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.contentMode = .scaleAspectFit
        
        imgView.image = UIImage(systemName: "arrow.right")
        imgView.tintColor = .white
            return imgView
            
        }()
    private lazy var exerciseCountText:UILabel = {
           let lbl = UILabel()
           
           lbl.translatesAutoresizingMaskIntoConstraints = false
           lbl.numberOfLines = 1
           lbl.font = .monospacedSystemFont(ofSize: 20, weight: .medium)
           
           lbl.textColor = .white
           
           
           return lbl
       }()
    private lazy var MuscleText:UILabel = {
            let lbl = UILabel()
            
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.numberOfLines = 1
            lbl.font = .monospacedSystemFont(ofSize: 30, weight: .bold)
            
            lbl.textColor = .white
            
            
            return lbl
        }()
    private lazy var containerView:UIView = {
           let vw = UIView()
           vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .clear
        vw.layer.borderWidth = 6
        vw.layer.borderColor = UIColor.openGreen.cgColor
        vw.layer.cornerRadius = 15
          
           return vw
       }()
    func configure(muscle:Muscle){
        self.contentView.addSubview(containerView)
        
        self.containerView.addSubview(MuscleText)
        self.containerView.addSubview(exerciseCountText)
        self.containerView.addSubview(arrowImage)
        
        self.MuscleText.text = muscle.muscle.capitalized
        self.exerciseCountText.text = "\(muscle.exercises.count) exercises"
        
        
        
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5.45),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant:6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant:-6),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25),
            
            
            MuscleText.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 14),
            MuscleText.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            
            exerciseCountText.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -14),
            exerciseCountText.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            
            arrowImage.heightAnchor.constraint(equalToConstant: 20),
            arrowImage.widthAnchor.constraint(equalToConstant: 20),
        
            
            arrowImage.centerYAnchor.constraint(equalTo: self.MuscleText.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -12),
        
        
            
            
        
        ])
    
    }
}

