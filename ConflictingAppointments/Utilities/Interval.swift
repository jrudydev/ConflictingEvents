//
//  Interval.swift
//  ConflictingAppointments
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import Foundation

struct Interval: Hashable {
  var min: Double
  var max: Double
  
  init(_ min: Double, _ max: Double) {
    self.min = min
    self.max = max
  }
}

extension Interval {
  func conflicts(with event: IntervalProtocol) -> Bool {
    return self.min < event.interval.max && event.interval.min < self.max
  }
}

extension Interval: CustomStringConvertible {
  var description: String {
    return "[\(min), \(max)]"
  }
}
