//
//  ViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/6/23.
//

import UIKit

class MainViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setup()
    }
  
    @objc func plusBtnTapped(){
            
  }
    
    private lazy var daysTableView:UITableView = {
        let tv = UITableView()
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UIScreen.main.bounds.height / 5
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
       
        return tv
    }()
    private lazy var dataManager = DataManager()
}


private extension MainViewController{
    func setup(){
        
        self.view.backgroundColor = .systemBackground
        setupNavigationBar()
        
        daysTableView.dataSource = self
        
        
        self.view.addSubview(daysTableView)
        NSLayoutConstraint.activate([
            daysTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            daysTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            daysTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            daysTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        
        ])
    }
  
    
    func setupNavigationBar(){
        // seting up image
        let image : UIImage = UIImage(systemName:"dumbbell.fill")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.tintColor = .label
        self.navigationItem.titleView = imageView
         let btn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(plusBtnTapped))
        btn.tintColor = .systemGreen
        
        
        self.navigationItem.rightBarButtonItem = btn
        
        
    }
    
}


extension MainViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = dataManager.days[indexPath.row]
        return UITableViewCell()
    }
    
    

}

