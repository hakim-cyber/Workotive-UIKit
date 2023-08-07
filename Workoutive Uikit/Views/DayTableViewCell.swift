//
//  DayTableViewCell.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/7/23.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
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
        lbl.font = .systemFont(ofSize: 30,weight: .bold)
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
        DayText.text = "Day \(day.id)"
        
        arrowImage.image = UIImage(systemName: "arrow.right")
    }

}
