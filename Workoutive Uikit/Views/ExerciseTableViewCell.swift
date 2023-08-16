//
//  ExerciseTableViewCell.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/16/23.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    static let cellId = "ExerciseTableViewCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private lazy var containerView:UIView = {
              let vw = UIView()
              vw.translatesAutoresizingMaskIntoConstraints = false
           
           vw.backgroundColor = .clear
           vw.layer.borderWidth = 6
           vw.layer.borderColor = UIColor.openGreen.cgColor
           vw.layer.cornerRadius = 15
             
              return vw
          }()
    private lazy var ExerciseText:UILabel = {
            let lbl = UILabel()
            
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.numberOfLines = 0
            lbl.font = .monospacedSystemFont(ofSize: 20, weight: .bold)
            lbl.adjustsFontSizeToFitWidth = true
            lbl.textColor = .white
            
            
            return lbl
        }()
    private lazy var setsAndRepsText:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = .monospacedSystemFont(ofSize: 33, weight: .bold)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        
        return lbl
    }()
    func configure(exercise:ExerciseApi){
        
        
        setsAndRepsText.text = "\(Int( exercise.sets ?? 0))x\( Int(exercise.repeatCount ?? 0))"
        ExerciseText.text = exercise.name.capitalized
        
        
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(setsAndRepsText)
        self.containerView.addSubview(ExerciseText)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 7),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant:6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant:-6),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25),
            
            ExerciseText.widthAnchor.constraint(equalToConstant: (self.contentView.bounds.width - 70) / 1.8),
            ExerciseText.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            ExerciseText.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant:  25),
            ExerciseText.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            ExerciseText.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16),
            

            setsAndRepsText.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            setsAndRepsText.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -25),
          
        
        ])
        
    }
   

}
