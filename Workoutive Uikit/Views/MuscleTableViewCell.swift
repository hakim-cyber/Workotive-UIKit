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
            return imgView
            
        }()
    private lazy var exerciseCountText:UILabel = {
           let lbl = UILabel()
           
           lbl.translatesAutoresizingMaskIntoConstraints = false
           lbl.numberOfLines = 1
           lbl.font = .monospacedSystemFont(ofSize: 20, weight: .medium)
           
           lbl.textColor = .black
           
           
           return lbl
       }()
    private lazy var MuscleText:UILabel = {
            let lbl = UILabel()
            
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.numberOfLines = 1
            lbl.font = .monospacedSystemFont(ofSize: 30, weight: .bold)
            
            lbl.textColor = .black
            
            
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
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
        
        ])
    
    }
}

