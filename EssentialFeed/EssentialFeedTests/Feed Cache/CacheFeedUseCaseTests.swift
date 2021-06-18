//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Elkana Orbach on 18/06/2021.
//

import XCTest

class LocalFeedLoader {
    init(store: FeedStore) {
    }
}

class FeedStore {
    var deleteCacheFeedCallCount = 0
}

class CacheFeeduseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store:store)
        
        XCTAssertEqual(store.deleteCacheFeedCallCount, 0)
    }
}
