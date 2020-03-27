//
//  ViewController.swift
//  ConflictingAppointments
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import UIKit

let cellId = "eventcell"

class TableViewController: UITableViewController {
  
  private var viewModel: TableViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
  
    self.viewModel = TableViewModel() {
      DispatchQueue.main.async {
        self.tableView.reloadData()
        print(self.viewModel.intervalTree)
      }
    }
  }
}

extension TableViewController {
  
  // MARK: TableViewControllerDelegate Methods
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel.sections.keys.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let date = self.viewModel.sortedDays[section]
    return self.viewModel.sections[date]?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let date = self.viewModel.sortedDays[section]
    return Event.sectionDateFormatter.string(from: date)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.backgroundColor = UIColor.clear
    
    let date = self.viewModel.sortedDays[indexPath.section]
    if let section = self.viewModel.sections[date] {
      let event = section[indexPath.row]
      
      cell.textLabel?.text = event.title
      cell.detailTextLabel?.text = "\(Event.eventDateFormatter.string(from: event.startDate)) - \(Event.eventDateFormatter.string(from: event.endDate))"
      cell.backgroundColor = self.viewModel.intervalTree.isConflicted(event) ? UIColor.red : cell.backgroundColor
    }
    
    return cell
  }
}

