//
//  DrawMarginTests.swift
//  TrueskillSwiftTests
//
//  Created by Brice Redmond on 7/15/20.
//  Copyright © 2020 Brice Redmond. All rights reserved.
//

import XCTest

class DrawMarginTests: XCTestCase {

    private let ErrorTolerance = 0.000001;

    func testDrawMarginFromDrawProbability() {
        let beta = 25.0/6.0
        
        AssertDrawMargin(0.10, beta, 0.74046637542690541)
        AssertDrawMargin(0.25, beta, 1.87760059883033)
        AssertDrawMargin(0.33, beta, 2.5111010132487492)
    }

    func AssertDrawMargin(_ drawProbability: Double, _ beta: Double, _ expected: Double) {
        let actual = DrawMargin.GetDrawMarginFromDrawProbability(drawProbability: drawProbability, beta: beta)
        XCTAssertEqual(expected, actual, accuracy: ErrorTolerance)
    }
}
