//
//  VC-Extension+TableViewDataSource.swift
//  DemoApp
//
//  Created by Selma Dsouza (Digital) on 26/11/19.
//  Copyright © 2019 Santanu Koley(Digital). All rights reserved.
//

import Foundation
import UIKit

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! RowsCell
        let currentLastItem = listViewModel.rows[indexPath.row]
        cell.row = currentLastItem
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
}
