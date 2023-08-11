//
//  ViewController.swift
//  Workoutive Uikit
//
//  Created by aplle on 8/6/23.
//

import UIKit

class MainViewController: UIViewController {
    private lazy var dataManager = DataManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setup()
    }
  
    @objc func plusBtnTapped(){
        var addView = AddViewController()
       
        addView.bind{[weak self] day in
           
            self?.dataManager.addDays(day: day)
            self?.daysTableView.reloadData()
            
            
        }
        addView.setupViewModel(days: dataManager.days)
            if let sheet = addView.sheetPresentationController{
                
                sheet.detents = [.large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersGrabberVisible = false
                sheet.preferredCornerRadius = 15
                
                
                
               
                present(addView, animated: true)
            
                
            }
        
  }
    
    private lazy var daysTableView:UITableView = {
        let tv = UITableView()
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = UIScreen.main.bounds.height / 5
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(DayTableViewCell.self, forCellReuseIdentifier: DayTableViewCell.cellId)
        tv.allowsSelection = true
        
        return tv
    }()
   
}


private extension MainViewController{
    func setup(){
        
        self.view.backgroundColor = .systemBackground
        setupNavigationBar()
        
        daysTableView.dataSource = self
        daysTableView.delegate = self
        
        
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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.tintColor = .label
        self.navigationItem.titleView = imageView
         let btn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(plusBtnTapped))
        btn.tintColor = UIColor.openGreen
        
        
        self.navigationItem.rightBarButtonItem = btn
        
        
    }
    
}


extension MainViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let day = dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.cellId, for: indexPath) as! DayTableViewCell
        cell.selectionStyle = .none
        cell.userInteractionEnabledWhileDragging = true
        cell.isUserInteractionEnabled = true
        cell.configure(day: day)
        
              return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            print("selected")
            let vc = MuscleViewController()
            
            vc.selectedDay = dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row]
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        
    }
    

}

