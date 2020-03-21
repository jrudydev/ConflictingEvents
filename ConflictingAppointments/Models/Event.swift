//
//  Event.swift
//  ConflictingAppointments
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import Foundation

public struct Event: Codable, IntervalProtocol, Hashable {
  var title: String
  var start: String
  var end: String
}

extension Event {
  // NOTE: Assuming that all dates are correct for now since it is a static file
  var startDate: Date {
    guard let date = Event.jsonDateFormatter.date(from: self.start) else {
      fatalError("Unable to parse date.")
    }
    return date
  }
  
  var endDate: Date {
    guard let date = Event.jsonDateFormatter.date(from: self.end) else {
      fatalError("Unable to parse date.")
    }
    return date
  }
  
  var interval: Interval {
    return Interval(self.startDate.timeIntervalSince1970, self.endDate.timeIntervalSince1970)
  }
}
