//
//  TableViewModel.swift
//  ConflictingAppointments
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import Foundation

class TableViewModel {
  
  let queue = DispatchQueue(label: "com.jrudygaming.com.fetchQueue")
  
  var sections = [Date: [Event]]()
  var sortedDays = [Date]()
  var intervalTree: IntervalTree!
  
  init(_ completion: @escaping () -> Void) {
    self.fetchData() { [weak self] events in
      self?.intervalTree = IntervalTree(events)
      let inOrder = self?.intervalTree.inOrder.map { $0 as! Event }
      self?.buildSections(inOrder ?? [])
      completion()
    }
  }
  
  private func buildSections(_ events: [Event]) {
    for event in events {
      let startTimestamp = Date(timeIntervalSince1970: event.interval.min)
      let strippedDate = Calendar.current.dateComponents([.year, .month, .day],
                                                         from: startTimestamp)
      
      guard let date = Calendar.current.date(from: strippedDate) else {
          fatalError("Failed to remove time from Date object")
      }
      
      self.sections[date, default: []].append(event)
    }
    
    self.sortedDays = self.sections.keys.sorted()
  }
  
  private func fetchData(_ completion: @escaping ([Event]) -> Void) {
    self.queue.async {
      completion(Bundle.main.eventJsonData(fileName: AppConstants.mockDataFilename) ?? [])
    }
  }

}
