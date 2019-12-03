//
//  VC-Extension+TableViewDelegate.swift
//  DemoApp
//
//  Created by Selma Dsouza (Digital) on 26/11/19.
//  Copyright © 2019 Santanu Koley(Digital). All rights reserved.
//

import Foundation
import UIKit

extension ListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
}
