//
//  ConflictingAppointmentsTests.swift
//  ConflictingAppointmentsTests
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import XCTest
@testable import ConflictingAppointments

class ConflictingAppointmentsTests: XCTestCase {

  let mockDateString = "November 10, 2018 6:00 PM"

  func testEventDecodable() {
    let jsonData = Bundle.main.eventJsonData(fileName: AppConstants.mockDataFilename)
    XCTAssertNotNil(jsonData)
    XCTAssert(jsonData!.count > 0)
  }
  
  func testEventTimeToDateFormatter() {
    XCTAssertNotNil(Event.jsonDateFormatter.date(from: self.mockDateString))
  }

}
