//
//  TableViewController.swift
//  InteractiveTableView
//
//  Created by Daniel Siegel on 01.01.17.
//  Copyright © 2017 Daniel Siegel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let dataSource = ["Klaus", "Malena", "Daniela", "Luisa", "Fritz", "Daniel", "Gitta", "HJ"]
    
    var isFirstRowShown = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFirstRowShown {
            return dataSource.count + 1
        } else {
            return dataSource.count
        }
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)

        // Configure the cell...
        if isFirstRowShown {

            if indexPath.row == 0 {
                cell.textLabel?.text = "Cool new Row"
            } else {
               cell.textLabel?.text = dataSource[indexPath.row + 1]
            }
        } else {
            cell.textLabel?.text = dataSource[indexPath.row]
        }
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let scrollOffset = scrollView.contentOffset.y
        print("Offset: \(scrollOffset)")
        if scrollOffset <= (0 - self.navigationController!.navigationBar.frame.size.height - 60) {
            showFirstCell()
        } else if scrollOffset > (0 - self.navigationController!.navigationBar.frame.size.height) {
            hideFirstCell()
        }
    }
    
    fileprivate func showFirstCell() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        if !isFirstRowShown {
            tableView.insertRows(at: [indexPath], with: .automatic)
            isFirstRowShown = true
        }
        tableView.endUpdates()
    }
    
    fileprivate func hideFirstCell() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        if isFirstRowShown {
            tableView.deleteRows(at: [indexPath], with: .automatic)
            isFirstRowShown = false
        }
        tableView.endUpdates()
    }

}
