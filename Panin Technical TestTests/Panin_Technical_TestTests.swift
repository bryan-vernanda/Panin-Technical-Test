//
//  Panin_Technical_TestTests.swift
//  Panin Technical TestTests
//
//  Created by Bryan Vernanda on 19/03/25.
//

import XCTest
@testable import Panin_Technical_Test

final class Panin_Technical_TestTests: XCTestCase {

    var mockContextManager: MockSwiftDataContextManager!
    var repository: LocalWatchlistRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockContextManager = MockSwiftDataContextManager()
        repository = LocalWatchlistRepository(modelContext: mockContextManager.context)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockContextManager = nil
        repository = nil
    }

    func testSaveWatchlist_Success() throws {
        let watchlist = WatchlistSchema(watchlistName: "BBCA")

        XCTAssertNoThrow(try repository.save(watchlist))

        let fetchedResult = repository.fetch(watchlistName: "BBCA")
        switch fetchedResult {
        case .success(let fetchedWatchlist):
            XCTAssertNotNil(fetchedWatchlist)
            XCTAssertEqual(fetchedWatchlist?.watchlistName, "BBCA")
        case .failure:
            XCTFail("Fetching the saved watchlist should not fail.")
        }
    }

    func testSaveWatchlist_AlreadyExists() throws {
        let watchlist = WatchlistSchema(watchlistName: "ASII")
        try repository.save(watchlist)

        XCTAssertThrowsError(try repository.save(watchlist)) { error in
            XCTAssertTrue(error is SwiftDataError)
        }
    }

    func testFetchAllWatchlists_Success() throws {
        let watchlist1 = WatchlistSchema(watchlistName: "ASII")
        let watchlist2 = WatchlistSchema(watchlistName: "BBCA")
        let watchlist3 = WatchlistSchema(watchlistName: "BBRI")
        let watchlist4 = WatchlistSchema(watchlistName: "BMRI")

        try repository.save(watchlist1)
        try repository.save(watchlist2)
        try repository.save(watchlist3)
        try repository.save(watchlist4)

        let result = repository.fetchAll()
        switch result {
        case .success(let watchlists):
            XCTAssertEqual(watchlists.count, 4)
            XCTAssertTrue(watchlists.contains { $0.watchlistName == "ASII" })
            XCTAssertTrue(watchlists.contains { $0.watchlistName == "BBCA" })
            XCTAssertTrue(watchlists.contains { $0.watchlistName == "BBRI" })
            XCTAssertTrue(watchlists.contains { $0.watchlistName == "BMRI" })
        case .failure:
            XCTFail("Fetching all watchlists should not fail.")
        }
    }

    func testFetchWatchlist_NotFound() {
        let result = repository.fetch(watchlistName: "ADMF")

        switch result {
        case .success(let watchlist):
            XCTAssertNil(watchlist)
        case .failure:
            XCTFail("Fetching a non-existent watchlist should not fail, but return nil.")
        }
    }

    func testDeleteWatchlist_Success() throws {
        let watchlist = WatchlistSchema(watchlistName: "BBCA")
        try repository.save(watchlist)

        XCTAssertNoThrow(try repository.delete("BBCA"))

        let result = repository.fetch(watchlistName: "BBCA")
        switch result {
        case .success(let fetchedWatchlist):
            XCTAssertNil(fetchedWatchlist)
        case .failure:
            XCTFail("Fetching a deleted watchlist should return nil, not an error.")
        }
    }

    func testDeleteWatchlist_NotFound() {
        XCTAssertThrowsError(try repository.delete("BBRI")) { error in
            XCTAssertTrue(error is SwiftDataError)
        }
    }
    
    func testFetchEmptyThenCreateThenDeleteAll() throws {
        // Fetch empty
        let initialFetchResult = repository.fetchAll()
        switch initialFetchResult {
        case .success(let watchlists):
            XCTAssertTrue(watchlists.isEmpty, "Initial fetch should be empty.")
        case .failure:
            XCTFail("Fetching all watchlists should not fail when empty.")
        }

        // Add & save watchlists
        let watchlists = [
            WatchlistSchema(watchlistName: "ASII"),
            WatchlistSchema(watchlistName: "BBCA"),
            WatchlistSchema(watchlistName: "BBRI"),
            WatchlistSchema(watchlistName: "BMRI")
        ]

        for watchlist in watchlists {
            XCTAssertNoThrow(try repository.save(watchlist))
        }

        // Fetch all watchlists
        let afterInsertFetchResult = repository.fetchAll()
        switch afterInsertFetchResult {
        case .success(let watchlists):
            XCTAssertEqual(watchlists.count, 4, "There should be 4 watchlists after insertion.")
        case .failure:
            XCTFail("Fetching after inserting stocks should not fail.")
        }

        // Delete all watchlist
        for watchlist in watchlists {
            XCTAssertNoThrow(try repository.delete(watchlist.watchlistName))
        }

        // Fetch all again, should be empty
        let afterDeleteFetchResult = repository.fetchAll()
        switch afterDeleteFetchResult {
        case .success(let watchlists):
            XCTAssertTrue(watchlists.isEmpty, "After deleting all, fetch should return empty.")
        case .failure:
            XCTFail("Fetching after deleting all stocks should not fail.")
        }
    }

}

