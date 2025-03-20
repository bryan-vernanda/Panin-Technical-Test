//
//  Panin_Technical_TestUITests.swift
//  Panin Technical TestUITests
//
//  Created by Bryan Vernanda on 19/03/25.
//

import XCTest

final class Panin_Technical_TestUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testTabSwitchingTwice() throws {
        let watchlistTab = app.tabBars.buttons["Watchlist"]
        let stockTab = app.tabBars.buttons["Stock"]

        XCTAssertTrue(watchlistTab.exists, "Watchlist tab should exist")
        watchlistTab.tap()

        XCTAssertTrue(stockTab.exists, "Stock tab should exist")
        stockTab.tap()

        XCTAssertTrue(watchlistTab.exists, "Watchlist tab should exist")
        watchlistTab.tap()

        XCTAssertTrue(stockTab.exists, "Stock tab should exist")
        stockTab.tap()
    }

    @MainActor
    func testStockListAppears() throws {
        let stockTab = app.tabBars.buttons["Stock"]
        stockTab.tap()

        let stockListHeader = app.staticTexts["Stock List"]
        XCTAssertTrue(stockListHeader.waitForExistence(timeout: 3), "Stock List header should be visible")

        let stockCell = app.cells.firstMatch
        XCTAssertTrue(stockCell.waitForExistence(timeout: 3), "Stock list should have at least one stock item")
    }

    @MainActor
    func testWatchlistPersistenceAfterAddingStock() throws {
        // Open Watchlist tab
        let watchlistTab = app.tabBars.buttons["Watchlist"]
        watchlistTab.tap()

        // Check watchlist, should be empty
        let noWatchlistText = app.staticTexts["No watchlist yet"]
        let watchlistCell = app.cells.firstMatch

        if noWatchlistText.exists {
            XCTAssertTrue(noWatchlistText.exists, "No watchlist message should be displayed if empty")
        } else {
            XCTAssertTrue(watchlistCell.exists, "Watchlist should have at least one item")
        }

        // Add a stock to the watchlist
        let addButton = app.buttons["plus"]
        XCTAssertTrue(addButton.exists, "Add button should exist in Watchlist view")
        addButton.tap()

        let stockListHeader = app.staticTexts["Stock List"]
        XCTAssertTrue(stockListHeader.waitForExistence(timeout: 3), "Stock List header should appear in the modal")

        let firstStock = app.cells.firstMatch
        XCTAssertTrue(firstStock.exists, "There should be at least one stock to add")
        firstStock.tap()

        let addToWatchlistButton = app.buttons.containing(NSPredicate(format: "label CONTAINS 'Add to Watchlist'")).firstMatch
        XCTAssertTrue(addToWatchlistButton.exists, "Add to Watchlist button should exist")
        addToWatchlistButton.tap()

        let closeButton = app.buttons["Close"]
        if closeButton.exists { closeButton.tap() }

        // Verify the newly added stock appears
        XCTAssertTrue(watchlistCell.waitForExistence(timeout: 3), "Newly added stock should appear in the Watchlist")

        // Close and reopen the app
        app.terminate()
        app.launch()

        // Navigate back to Watchlist tab
        watchlistTab.tap()

        // Verify the watchlist still has at least one stock
        XCTAssertTrue(watchlistCell.waitForExistence(timeout: 3), "Watchlist should retain the added stock after restarting the app")
    }

    @MainActor
    func testAddAndRemoveStockFromWatchlist() throws {
        let watchlistTab = app.tabBars.buttons["Watchlist"]
        watchlistTab.tap()

        // Check if Watchlist is empty
        let noWatchlistText = app.staticTexts["No watchlist yet"]
        let watchlistCell = app.cells.firstMatch
        
        if noWatchlistText.exists {
            XCTAssertTrue(noWatchlistText.exists, "Watchlist is initially empty")
        } else {
            // If watchlist already has items, clear it first
            while watchlistCell.exists {
                watchlistCell.swipeLeft()
                let deleteButton = app.buttons["Delete"]
                XCTAssertTrue(deleteButton.exists, "Delete button should appear on swipe")
                deleteButton.tap()
                
                let confirmDeleteButton = app.buttons["Delete"]
                if confirmDeleteButton.exists {
                    confirmDeleteButton.tap()
                }
            }
            XCTAssertTrue(noWatchlistText.waitForExistence(timeout: 3), "Watchlist should be empty after clearing")
        }

        // Add a stock to the Watchlist
        let addButton = app.buttons["plus"]
        XCTAssertTrue(addButton.exists, "Add button should exist in Watchlist view")
        addButton.tap()

        let stockListHeader = app.staticTexts["Stock List"]
        XCTAssertTrue(stockListHeader.waitForExistence(timeout: 3), "Stock List header should appear in the modal")

        let firstStock = app.cells.firstMatch
        XCTAssertTrue(firstStock.exists, "There should be at least one stock to add")
        firstStock.tap()

        let addToWatchlistButton = app.buttons.containing(NSPredicate(format: "label CONTAINS 'Add to Watchlist'")).firstMatch
        XCTAssertTrue(addToWatchlistButton.exists, "Add to Watchlist button should exist")
        addToWatchlistButton.tap()

        let closeButton = app.buttons["Close"]
        if closeButton.exists { closeButton.tap() }

        // Verify stock was added
        XCTAssertTrue(watchlistCell.waitForExistence(timeout: 3), "Stock should be added to Watchlist")

        // Remove the stock
        watchlistCell.swipeLeft()
        let deleteButton = app.buttons["Delete"]
        XCTAssertTrue(deleteButton.exists, "Delete button should appear on swipe")
        deleteButton.tap()
        
        let confirmDeleteButton = app.buttons["Delete"]
        if confirmDeleteButton.exists {
            confirmDeleteButton.tap()
        }

        // Verify Watchlist is empty
        XCTAssertTrue(noWatchlistText.waitForExistence(timeout: 3), "Watchlist should be empty after deleting stock")

        // Close and relaunch the app
        app.terminate()
        app.launch()
        
        // Navigate back to Watchlist tab
        watchlistTab.tap()

        // Verify Watchlist is still empty after relaunch
        XCTAssertTrue(noWatchlistText.waitForExistence(timeout: 3), "Watchlist should remain empty after restarting the app")
    }

}
