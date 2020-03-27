//
//  IntervalTree.swift
//  ConflictingAppointments
//
//  Created by Rudy Gomez on 3/20/20.
//  Copyright © 2020 JRudy Gaming. All rights reserved.
//

class IntervalNode<T: IntervalProtocol> {
  let event: IntervalProtocol
  var maxValue: Double
  var left: IntervalNode?
  var right: IntervalNode?
  
  init(_ event: IntervalProtocol) {
    self.event = event
    self.maxValue = event.interval.max
  }
}


// This calls will create a BST based on the lower value of the interval and
// will keep track of conflicting intervals with a unique set. Achieves
// O(nLogn) for the tree creation and O(Logn + m) for the conflict detection
// where n is the number of elements and m is the number of conflicting intervals.
struct IntervalTree {
  var root: IntervalNode<Event>?
  var conflicted = Set<Event>()
  
  init(_ appointments: [Event]) {
    self.crateIntervalTree(appointments)
  }
  
  func isConflicted(_ event: Event) -> Bool {
    return self.conflicted.contains(event)
  }
  
  // This funciton will create the interval tree from a list of events.
  // Time Complexity: Achieve O(nLogn)
  private mutating func crateIntervalTree(_ events: [Event]) {
    guard let first = events.first else { return }
    
    self.root = insert(self.root, event: first)
    
    for event in events[1...] {
      var conflicts = [IntervalProtocol]()
      conflictSearch(self.root, event: event, conflicts: &conflicts)
      if conflicts.count > 0 { self.conflicted.insert(event) }
      for conflict in conflicts {
        if let unwrappedConflict = conflict as? Event {
          self.conflicted.insert(unwrappedConflict)
        }
      }
      
      self.root = insert(self.root, event: event)
    }
  }
}

extension IntervalTree {
  // This funciton will insert an event into the interval tree.
  // Time Complexity: O(Logn)
  private func insert(_ node: IntervalNode<Event>?, event: IntervalProtocol) -> IntervalNode<Event> {
    guard let root = node else { return IntervalNode(event) }
    
    let low = root.event.interval.min
    if event.interval.min < low {
      root.left = insert(root.left, event: event)
    } else {
      root.right = insert(root.right, event: event)
    }
    
    root.maxValue = max(root.maxValue, event.interval.max)
    
    return root
  }
  
  // This funciton is used to detect and track conflicts in the interval tree.
  // Time Complexity: O(Logn)
  private func conflictSearch(_ node: IntervalNode<Event>?, event: IntervalProtocol, conflicts: inout [IntervalProtocol]) {
    guard let root = node else { return }
    
    if root.event.interval.conflicts(with: event) {
      conflicts += [root.event]
    }
    
    if let left = root.left, left.maxValue >= event.interval.min {
      conflictSearch(left, event: event, conflicts: &conflicts)
    }
  
    conflictSearch(root.right, event: event, conflicts: &conflicts)
  }
}

extension IntervalTree: CustomStringConvertible {
  var description: String {
    return String(describing: self.inOrder)
  }
  
  var inOrder: [IntervalProtocol] {
    return self._inOrder(self.root)
  }
  
  private func _inOrder(_ node: IntervalNode<Event>?) -> [IntervalProtocol] {
    guard let root = node else { return [] }
  
    return self._inOrder(root.left) + [root.event] + self._inOrder(root.right)
  }
}
