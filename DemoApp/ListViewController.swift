//
//  ListViewController.swift
//  DemoApp
//
//  Created by Selma Dsouza (Digital) on 25/11/19.
//  Copyright © 2019 Santanu Koley(Digital). All rights reserved.
//

import UIKit
import Alamofire

let myArry:NSArray = ["First","Second","Third"]
class ListViewController: UIViewController {
    lazy var listViewModel: ListViewModel  = {
        return ListViewModel()
    }()
    let cellId = "cellId"
    var products : [Rows]  = [Rows]()
    private var listTableView: UITableView!
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        listTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        listTableView.register(RowsCell.self, forCellReuseIdentifier: cellId)
        listTableView.estimatedRowHeight = 70
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.dataSource = self
        listTableView.delegate = self
        self.view.addSubview(listTableView)
        
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        listTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 45, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: self.view.frame.size.width, height: self.view.frame.height - 5, enableInsets: false)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        listTableView.addSubview(refreshControl)
        
        callAPI()
        
    }
    
    private func callAPI(){
        let dataDownloadCompletionClosure = { [unowned self] (listData:Json4Swift_Base) ->Void in
            DispatchQueue.main.async {
                self.navigationItem.title = self.listViewModel.title
                self.listTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
        listViewModel.getRequestAPICall(completionHanlder: dataDownloadCompletionClosure)
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        callAPI()
        refreshControl.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.setNavigationBar()
    }
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        navBar.barTintColor = UIColor.red
        self.view.addSubview(navBar)
    }
    @objc func done() {
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


