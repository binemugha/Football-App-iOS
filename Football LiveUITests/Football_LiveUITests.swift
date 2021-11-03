//
//  Football_LiveUITests.swift
//  Football LiveUITests
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import XCTest

class Football_LiveUITests: XCTestCase {

    func testFavoriteBtnClicks(){
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Favorites"].exists)
    }
    
    func testAddFavouriteTeamIconClicks(){
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
        app.navigationBars["Favorites"].buttons["Add"].tap()
        XCTAssertTrue(app.navigationBars["Favorites"].buttons["Add"].exists)
    }
    
    func testAddFavouriteTeam(){
        
        
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
        app.navigationBars["Favorites"].buttons["Add"].tap()
        app.tables["Empty list"].tap()
        app.activityIndicators["In progress"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["AC Chievo Verona"]/*[[".cells.staticTexts[\"AC Chievo Verona\"]",".staticTexts[\"AC Chievo Verona\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["AC Chievo Verona"]/*[[".cells.staticTexts[\"AC Chievo Verona\"]",".staticTexts[\"AC Chievo Verona\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
       
    }
    
    
   
}
