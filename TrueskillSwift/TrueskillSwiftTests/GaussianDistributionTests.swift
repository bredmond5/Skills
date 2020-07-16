//
//  GaussianDistributionTests.swift
//  TrueskillSwiftTests
//
//  Created by Brice Redmond on 7/8/20.
//  Copyright © 2020 Brice Redmond. All rights reserved.
//

import XCTest

class GaussianDistributionTests: XCTestCase {
    
    private let ErrorTolerance = 0.000001

    func testCumlativeTo() {
        // Verified with WolframAlpha
        // (e.g. http://www.wolframalpha.com/input/?i=CDF%5BNormalDistribution%5B0%2C1%5D%2C+0.5%5D )
        XCTAssertEqual(0.691462, GaussianDistribution.CumulativeTo(0.5), accuracy: ErrorTolerance)
    }
    
    func testAt() {
        // Verified with WolframAlpha
        // (e.g. http://www.wolframalpha.com/input/?i=PDF%5BNormalDistribution%5B0%2C1%5D%2C+0.5%5D )
        XCTAssertEqual(0.352065, GaussianDistribution.At(0.5), accuracy: ErrorTolerance)
    }
    
    func testMultiplication() {
        // Verified against the formula at http://www.tina-vision.net/tina-knoppix/tina-memo/2003-003.pdf
        let standardNormal = GaussianDistribution(mean: 0, standardDeviation: 1)
        let shiftedGaussian = GaussianDistribution(mean: 2, standardDeviation: 3)
        
        let product = standardNormal * shiftedGaussian
        
        XCTAssertEqual(0.2, product.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(3.0/sqrt(10), product.StandardDeviation, accuracy: ErrorTolerance)
        
        let m4s5 = GaussianDistribution(mean: 4, standardDeviation: 5)
        let m6s7 = GaussianDistribution(mean: 6, standardDeviation: 7)
        
        let product2 = m4s5 * m6s7
        
        func square(_ x: Double) -> Double { return x*x }
        
        let expectedMean = (4 * square(7) + 6 * square(5)) / (square(5) + square(7))
        XCTAssertEqual(expectedMean, product2.Mean, accuracy: ErrorTolerance)
        
        let expectedSigma = sqrt((square(5) * square(7)) / (square(5) + square(7)))
        XCTAssertEqual(expectedSigma, product2.StandardDeviation, accuracy: ErrorTolerance)
    }
    
    func testDivision() {
        let product = GaussianDistribution(mean: 0.2, standardDeviation: 3.0/sqrt(10))
        let standardNormal = GaussianDistribution(mean: 0, standardDeviation: 1)
        
        let productDividedByStandardNormal = product / standardNormal
        XCTAssertEqual(2.0, productDividedByStandardNormal.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(3.0, productDividedByStandardNormal.StandardDeviation, accuracy: ErrorTolerance)
        
        func square(_ x :Double) -> Double {return x*x}
        
        let product2 = GaussianDistribution(mean: (4 * square(7) + 6*square(5))/(square(5) + square(7)), standardDeviation: sqrt((square(5) * square(7)) / (square(5) + square(7))))
        
        let m4s5 = GaussianDistribution(mean: 4, standardDeviation: 5)
        let product2DividedByM4S5 = product2 / m4s5
        
        XCTAssertEqual(6.0, product2DividedByM4S5.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(7.0, product2DividedByM4S5.StandardDeviation, accuracy: ErrorTolerance)
    }
    
    func testLogProductNormalization() {
        let standardNormal = GaussianDistribution(mean: 0,standardDeviation: 1)
        let lpn = GaussianDistribution.LogProductNormalization(lhs: standardNormal, rhs: standardNormal)
        XCTAssertEqual(-1.2655121234846454, lpn, accuracy: ErrorTolerance)
        
        let m1s2 = GaussianDistribution(mean: 1, standardDeviation: 2)
        let m3s4 = GaussianDistribution(mean: 3, standardDeviation: 4)
        let lpn2 = GaussianDistribution.LogProductNormalization(lhs: m1s2, rhs: m3s4)
        XCTAssertEqual(-2.5168046699816684, lpn2, accuracy: ErrorTolerance)
    }
    
    func testLogRatioNormalization() {
        let m1s2 = GaussianDistribution(mean: 1, standardDeviation: 2)
        let m3s4 = GaussianDistribution(mean: 3, standardDeviation: 4)
        let lrn = GaussianDistribution.LogRatioNormalization(numerator: m1s2, denominator: m3s4)
        
        XCTAssertEqual(2.6157405972171204, lrn, accuracy: ErrorTolerance)
    }
    
    func testAbsoluteDifference() {
        let standardNormal = GaussianDistribution(mean: 0, standardDeviation: 1)
        let absDiff = GaussianDistribution.AbsoluteDifference(lhs: standardNormal, rhs: standardNormal)
        XCTAssertEqual(0.0, absDiff, accuracy: ErrorTolerance)
        
        let m1s2 = GaussianDistribution(mean: 1, standardDeviation: 2)
        let m3s4 = GaussianDistribution(mean: 3, standardDeviation: 4)
        
        let absDiff2 = GaussianDistribution.AbsoluteDifference(lhs: m1s2, rhs: m3s4)
        XCTAssertEqual(0.4330127018922193, absDiff2, accuracy: ErrorTolerance)

    }
}
