//
//  Bundle+jsonData.swift
//  ConflictingAppointments
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

import Foundation

public extension Bundle {
  func eventJsonData(fileName: String) -> [Event]? {
    guard let url = self.url(forResource: fileName, withExtension: "json") else {
      fatalError("File was not reachable.")
    }
    
    guard let data = try? Data(contentsOf: url) else {
      fatalError("File was not readable.")
    }
    
    return try? JSONDecoder().decode([Event].self, from: data)
  }
}
