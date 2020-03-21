//
//  ConflictingAppointmentsIntervalTreeTests.swift
//  ConflictingAppointmentsTests
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import XCTest
@testable import ConflictingAppointments


class ConflictingAppointmentsIntervalTreeTests: XCTestCase {
  
  static let mockDateString6pm = "November 10, 2018 6:00 PM"
  static let mockDateString10pm = "November 10, 2018 10:00 PM"
  static let mockDateString8pm = "November 10, 2018 8:00 PM"
  static let mockDateString11pm = "November 10, 2018 11:00 PM"
  
  static let event1 = Event(title: "event1",
                     start: ConflictingAppointmentsIntervalTreeTests.mockDateString8pm,
                     end: ConflictingAppointmentsIntervalTreeTests.mockDateString10pm)
  
  static let event2 = Event(title: "event2",
                     start: ConflictingAppointmentsIntervalTreeTests.mockDateString10pm,
                     end: ConflictingAppointmentsIntervalTreeTests.mockDateString11pm)
  
  static let event3 = Event(title: "event3",
                     start: ConflictingAppointmentsIntervalTreeTests.mockDateString6pm,
                     end: ConflictingAppointmentsIntervalTreeTests.mockDateString8pm)
  
  let events = [ConflictingAppointmentsIntervalTreeTests.event1,
                ConflictingAppointmentsIntervalTreeTests.event2,
                ConflictingAppointmentsIntervalTreeTests.event3]
  let ordered = [ConflictingAppointmentsIntervalTreeTests.event3,
                 ConflictingAppointmentsIntervalTreeTests.event1,
                 ConflictingAppointmentsIntervalTreeTests.event2]
  var tree: IntervalTree!

  override func setUp() {
    self.tree = IntervalTree(self.events)
  }
  
  func testIntervalTreeNodeMaxValue() {
    XCTAssertNotNil(self.tree.root)
    XCTAssertNotNil(self.tree.root!.left)
    XCTAssertNotNil(self.tree.root!.right)
    
    let timestamp11pmDate = Event.jsonDateFormatter.date(from: ConflictingAppointmentsIntervalTreeTests.mockDateString11pm)!
    let timestamp8pmDate = Event.jsonDateFormatter.date(from: ConflictingAppointmentsIntervalTreeTests.mockDateString8pm)!
    XCTAssert(self.tree.root!.maxValue == timestamp11pmDate.timeIntervalSince1970)
    XCTAssert(self.tree.root!.left!.maxValue == timestamp8pmDate.timeIntervalSince1970)
    XCTAssert(self.tree.root!.right!.maxValue == timestamp11pmDate.timeIntervalSince1970)
  }
  
  func testIntervalTreeInOrderList() {
    let inOrder = self.tree.inOrder
    for (idx, event) in self.ordered.enumerated() {
      guard let treeEvent = inOrder[idx] as? Event else { continue }
      XCTAssert(event.title == treeEvent.title)
    }
  }
  
}
