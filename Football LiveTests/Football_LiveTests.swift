//
//  Football_LiveTests.swift
//  Football LiveTests
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import XCTest
@testable import Football_Live

class Football_LiveTests: XCTestCase {

    func testGetTeamDescriptionRequestCorrectUrl() {
        let request = NetworkManager.shared.getTeamDescriptionRequest(1)
        XCTAssertEqual(request.url, URL(string: "https://api.football-data.org/v2/teams/1"))
    }
    
    func testGetTeamsFromAreaRequestCorrecttUrl() {
        let request = NetworkManager.shared.getTeamsFromAreaRequest(.Europe)
        XCTAssertEqual(request.url, URL(string: "https://api.football-data.org/v2/teams?areas=2077"))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }


}
