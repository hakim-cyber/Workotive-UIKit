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
            Task{
                await self?.dataManager.addDays(day: day)
                self?.daysTableView.reloadData()
                
            }
            
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
        tv.estimatedRowHeight = UIScreen.main.bounds.height / 5.45
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(DayTableViewCell.self, forCellReuseIdentifier: DayTableViewCell.cellId)
        tv.allowsSelection = true
        
        return tv
    }()
   
}


private extension MainViewController{
    func setup(){
        overrideUserInterfaceStyle = .dark   
        self.view.backgroundColor = .systemBackground
        setupNavigationBar()
        
        daysTableView.dataSource = self
        daysTableView.delegate = self
        self.daysTableView.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 35,right: 0)
        
        self.view.addSubview(daysTableView)
        NSLayoutConstraint.activate([
            daysTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            daysTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
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
        imageView.tintColor = .white
        self.navigationItem.titleView = imageView
         let btn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(plusBtnTapped))
        btn.tintColor = UIColor.openGreen
        
        
        self.navigationItem.rightBarButtonItem = btn
        navigationController?.navigationBar.barTintColor = .clear
        
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
        cell.backgroundColor = .clear
       
        cell.configure(day: day)
       
              return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            print("selected")
            let vc = MuscleViewController()
        var selectedDay = dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row]
        vc.bind { event in
            switch event {
            case .newMuscle(let muscle):
                self.dataManager.addMuscleTo(dayID:self.dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row].id , muscle: muscle)
                self.daysTableView.reloadData()
                
                vc.selectedDay = self.dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row]
                vc.filterMuscles()
            case .deleteMuscle(let muscle):
                self.dataManager.deleteMuscleAt(dayID: self.dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row].id, muscle: muscle)
                self.daysTableView.reloadData()
                
                vc.selectedDay = self.dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row]
                vc.filterMuscles()
            case .deleteExercise(let exercise,let  muscle):
                self.dataManager.deleteExercise(muscleid: muscle.id, dayId: selectedDay.id, exerciseID: exercise.id)
                self.daysTableView.reloadData()
                vc.selectedDay = self.dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row]
                vc.filterMuscles()
            }
          
        }
       
            vc.selectedDay = selectedDay
        vc.filterMuscles()
            self.navigationController?.pushViewController(vc, animated: true)
            
        
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { action, voew, completHandler in
            print("Delete \(indexPath.row)")
            
            let day = self.dataManager.days.sorted(by: {$0.id < $1.id})[indexPath.row]
            self.dataManager.removeDay(day: day)
            self.daysTableView.reloadData()
            
            completHandler(true)
        }
        delete.backgroundColor = .black
        delete.image = UIImage(systemName: "trash.fill")
        delete.image?.withTintColor(.systemRed)
        
    
        
        return UISwipeActionsConfiguration(actions: [delete])
    }

}
