//
//  TwoPlayerTrueSkillCalculatorTest.swift
//  TrueskillSwiftTests
//
//  Created by Brice Redmond on 7/8/20.
//  Copyright © 2020 Brice Redmond. All rights reserved.
//

import XCTest

class TwoPlayerTrueSkillCalculatorTest: XCTestCase {

    private let ErrorTolerance = 0.085;
    private var player1: Player<Int>?
    private var player2: Player<Int>?
    
    private var gameInfo: GameInfo?
    private var teams: [[Player<Int> : Rating]]?
    
    private var calculator: SkillCalculator {
        return TwoPlayerTrueSkillCalculator()
    }
    
    override internal func setUp() {
        player1 = Player(id: 1)
        player2 = Player(id: 2)
        
        gameInfo = GameInfo.DefaultGameInfo
        
        let team1 = Team(firstPlayer: player1!, playerRating: gameInfo!.DefaultRating)
        let team2 = Team(firstPlayer: player2!, playerRating: gameInfo!.DefaultRating)
        
        teams = Teams.Concat(team1, team2)
    }

    
    func testTwoPlayerNotDrawn() {
        let newRatings = calculator.CalculateNewRatings(gameInfo: gameInfo!, teams: teams!, teamRanks: 1,2)
        
        let player1NewRating = newRatings[player1!]
        XCTAssertEqual(29.39583201999924, player1NewRating!.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(7.171475587326186, player1NewRating!.StandardDeviation, accuracy: ErrorTolerance)
//        AssertRating(29.39583201999924, 7.171475587326186, player1NewRating!)
        
        let player2NewRating = newRatings[player2!]
        XCTAssertEqual(20.60416798000076, player2NewRating!.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(7.171475587326186, player2NewRating!.StandardDeviation, accuracy: ErrorTolerance)
        
        XCTAssertEqual(0.447, calculator.CalculateMatchQuality(gameInfo: gameInfo!, teams: teams!), accuracy: ErrorTolerance)
        
    }
    
    func testTwoPlayerDrawn() {
        let newRatings = calculator.CalculateNewRatings(gameInfo: gameInfo!, teams: teams!, teamRanks: 1,1)
        
        let player1NewRating = newRatings[player1!]
        XCTAssertEqual(25.0, player1NewRating!.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(6.4575196623173081, player1NewRating!.StandardDeviation, accuracy: ErrorTolerance)
        
        let player2NewRating = newRatings[player2!]
        XCTAssertEqual(25.0, player2NewRating!.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(6.4575196623173081, player2NewRating!.StandardDeviation, accuracy: ErrorTolerance)
        
        XCTAssertEqual(0.447, calculator.CalculateMatchQuality(gameInfo: gameInfo!, teams: teams!), accuracy: ErrorTolerance)
    }
    
    func testOneOnOneMassiveUpsetDraw() {
        let team1 = Team().AddPlayer(player: player1!, rating: gameInfo!.DefaultRating)
        let team2 = Team().AddPlayer(player: player2!, rating: Rating(mean: 50, standardDeviation: 12.5));
        let teams = Teams.Concat(team1, team2);

        let newRatingsWinLose = calculator.CalculateNewRatings(gameInfo: gameInfo!, teams: teams, teamRanks: 1, 1)

        // Winners
        let player1NewRating = newRatingsWinLose[player1!]
        XCTAssertEqual(31.662, player1NewRating!.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(7.137, player1NewRating!.StandardDeviation, accuracy: ErrorTolerance)

        // Losers
        let player2NewRating = newRatingsWinLose[player2!]
        XCTAssertEqual(35.010, player2NewRating!.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(7.910, player2NewRating!.StandardDeviation, accuracy: ErrorTolerance)

        XCTAssertEqual(0.110, calculator.CalculateMatchQuality(gameInfo: gameInfo!, teams: teams), accuracy: ErrorTolerance)
    }
    
    func testTwoPlayerChessNotDrawn() {
        let gameInfo = GameInfo(initialMean: 1200.0, initialStandardDeviation: 1200.0 / 3.0, beta: 200.0, dynamicsFactor: 1200.0 / 300.0, drawProbability: 0.03)
        
        let team1 = Team(firstPlayer: player1!, playerRating: Rating(mean: 1301.0007, standardDeviation: 42.9232))
        let team2 = Team(firstPlayer: player2!, playerRating: Rating(mean: 1188.7560, standardDeviation: 42.5570))

        let newRatings = calculator.CalculateNewRatings(gameInfo: gameInfo, teams: Teams.Concat(team1, team2), teamRanks: 1, 2)

        let player1NewRating = newRatings[player1!]
        
        XCTAssertEqual(1304.7820836053318, player1NewRating!.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(42.843513887848658, player1NewRating!.StandardDeviation, accuracy: ErrorTolerance)
        
        let player2NewRating = newRatings[player2!]
        XCTAssertEqual(1185.0383099003536, player2NewRating!.Mean, accuracy: ErrorTolerance)
        XCTAssertEqual(42.485604606897752, player2NewRating!.StandardDeviation, accuracy: ErrorTolerance)
    }
    
    
}
