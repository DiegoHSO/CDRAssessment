//
//  Extensions.swift
//  CDRAssessment
//
//  Created by Diego Henrique Silva Oliveira on 06/01/23.
//

import Foundation


extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
    
    func back() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let previous = idx == all.startIndex ? all.endIndex : all.index(idx, offsetBy: -1)
        return all[previous]
    }
}

extension Sequence where Element: Hashable {
    var frequency: [Element: Int] { reduce(into: [:]) { $0[$1, default: 0] += 1 } }
    var mostFrequent: (mostFrequent: [Element], count: Int)? {
        guard let maxCount = frequency.values.max() else { return nil }
        return (frequency.compactMap { $0.value == maxCount ? $0.key : nil }, maxCount)
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
