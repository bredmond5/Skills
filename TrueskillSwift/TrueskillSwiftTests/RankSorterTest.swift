//
//  RankSorterTest.swift
//  TrueskillSwiftTests
//
//  Created by Brice Redmond on 7/12/20.
//  Copyright © 2020 Brice Redmond. All rights reserved.
//

import XCTest

class RankSorterTest: XCTestCase {

    func testAlreadySorted() {
        let people = ["One", "Two", "Three"]
        let ranks = [1,2,3]
        
        let (newPeople, newRanks) = RankSorter.Sort(teams: people, teamRanks: ranks)
        
        XCTAssertEqual(newPeople, people)
        XCTAssertEqual(newRanks, ranks)
    }

    func testUnsorted() {
        let people = ["Five", "Two1", "Two2", "One", "Four"]
        let ranks = [5, 2, 2, 1, 4]
        
        let (newPeople, newRanks) = RankSorter.Sort(teams: people, teamRanks: ranks)
        
        XCTAssertEqual(newPeople,  ["One", "Two1", "Two2", "Four", "Five"])
        XCTAssertEqual(newRanks, [1, 2, 2, 4, 5])
    }
}
