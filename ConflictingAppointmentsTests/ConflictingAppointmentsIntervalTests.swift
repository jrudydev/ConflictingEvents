//
//  ConflictingAppointmentsIntervalTests.swift
//  ConflictingAppointmentsTests
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import XCTest
@testable import ConflictingAppointments

class ConflictingAppointmentsIntervalTests: XCTestCase {
  
  let mockDateString6pm = "November 10, 2018 6:00 PM"
  let mockDateString10pm = "November 10, 2018 10:00 PM"
  let mockDateString8pm = "November 10, 2018 8:00 PM"
  let mockDateString11pm = "November 10, 2018 11:00 PM"

  func testIntervalConflictsWith() {
    let event1 = Event(title: "", start: mockDateString6pm, end: mockDateString10pm)
    let event2 = Event(title: "", start: mockDateString8pm, end: mockDateString11pm)
    
    XCTAssert(event1.interval.conflicts(with: event2))
  }
  
  func testIntervalDoesNotConflictsWith() {
    let event1 = Event(title: "", start: mockDateString6pm, end: mockDateString8pm)
    let event2 = Event(title: "", start: mockDateString10pm, end: mockDateString11pm)
    
    XCTAssert(!event1.interval.conflicts(with: event2))
  }
  
  func testIntervalDoesNotConflictEdgeToEdge() {
    let event1 = Event(title: "", start: mockDateString6pm, end: mockDateString8pm)
    let event2 = Event(title: "", start: mockDateString8pm, end: mockDateString11pm)
    
    XCTAssert(!event1.interval.conflicts(with: event2))
  }
  
}
