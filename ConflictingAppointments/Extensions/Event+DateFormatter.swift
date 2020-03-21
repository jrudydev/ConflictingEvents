//
//  Event+DateFormatter.swift
//  ConflictingAppointments
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import Foundation

extension Event {
  public static var jsonDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = AppConstants.jsonDataFormat
    return formatter
  }()
  
  public static var sectionDateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = AppConstants.sectionDateFormat
      return formatter
  }()
  
  public static var eventDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = AppConstants.eventDateFormat
    return formatter
  }()
}
