//
//  DayTableViewCell.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/7/23.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    static let cellId = "DayTableViewCell"

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 15
    }
    private lazy var containerView:UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
       
        return vw
    }()
    
    private lazy var DayText:UILabel = {
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        
        lbl.textColor = .black
        
        
        return lbl
    }()
    private lazy var arrowImage:UIImageView = {
        let imgView = UIImageView()
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
        
    }()
    private lazy var trashBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .red
        
        return btn
    }()
    
    func configure(day:Day){
        switch day.id{
        case 1:
            DayText.text = "Monday"
        case 2:
            DayText.text = "Tuesday"
        case 3:
            DayText.text = "Wednesday"
        case 4:
            DayText.text = "Thursday"
        case 5:
            DayText.text = "Friday"
        case 6:
            DayText.text = "Saturday"
        default:
            DayText.text = "Sunday"
        }
        
        
        
        arrowImage.image = UIImage(systemName: "arrow.right")
        arrowImage.tintColor = .black
    
        containerView.backgroundColor = UIColor.openGreen
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(DayText)
        containerView.addSubview(arrowImage)
       
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5.3),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: day.id == 1 ? 40: 4),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
        
            DayText.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8),
            DayText.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            
            arrowImage.heightAnchor.constraint(equalToConstant: 20),
            arrowImage.widthAnchor.constraint(equalToConstant: 20),
        
            
            arrowImage.centerYAnchor.constraint(equalTo: self.DayText.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -12),
        
        
        
        
        ])
    }

}
