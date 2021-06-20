//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Elkana Orbach on 18/06/2021.
//

import XCTest
import EssentialFeed

class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    init(store: FeedStore, currentDate: @escaping () -> Date = Date.init) {
        self.store = store
        self.currentDate = currentDate
    }
    
    func save(_ items: [FeedItem], completion: @escaping (Error?) -> Void) {
        store.deleteCacheFeed {[unowned self] error in
            completion(error)
            if error == nil {
                self.store.insert(items, timestamp: self.currentDate())
            }
        }
    }
}

class FeedStore {
    typealias DeletionCompletion = (Error?)-> Void
    
    
    enum ReceivedMessage: Equatable {
        case deleteCachedFeed
        case insert(items:[FeedItem],timestamp:Date)
    }
    
    private(set) var receivedMesages = [ReceivedMessage]()
    
    private var deletionCompletions = [DeletionCompletion]()
    
    func deleteCacheFeed(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedMesages.append(.deleteCachedFeed)
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deletionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deletionCompletions[index](nil)
    }
    
    func insert(_ items:[FeedItem],timestamp:Date) {
        receivedMesages.append(.insert(items: items, timestamp: timestamp))
    }
}

class CacheFeeduseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMesages, [])
    }
    
    func test_save_requestCacheDeletion() {
        let items = [uniqueItem(),uniqueItem()]
        let (sut, store) = makeSUT()
        sut.save(items) { _ in }
        XCTAssertEqual(store.receivedMesages, [.deleteCachedFeed])
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeletionError() {
        let items = [uniqueItem(),uniqueItem()]
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        sut.save(items) { _ in }
        store.completeDeletion(with:deletionError)
        
        XCTAssertEqual(store.receivedMesages,[.deleteCachedFeed])
    }
    
    func test_save_requestsNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
        let timestamp = Date()
        let items = [uniqueItem(),uniqueItem()]
        let (sut, store) = makeSUT(currentDate: { timestamp })
        
        sut.save(items) { _ in }
        store.completeDeletionSuccessfully()
        
        XCTAssertEqual(store.receivedMesages,[.deleteCachedFeed,.insert(items: items, timestamp: timestamp)])
    }
    
    func test_save_failOnDeletionError() {
        let items = [uniqueItem(),uniqueItem()]
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        let exp = expectation(description: "Wait for save completion")

        var receivedError: Error?
        sut.save(items) { error in
            receivedError = error
            exp.fulfill()
        }
        store.completeDeletion(with:deletionError)
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError as NSError?,deletionError)
    }
    
    //MARK: - Helpers
    private func makeSUT(currentDate: @escaping ()-> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStore) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store:store,currentDate: currentDate)
        trackForMemoryLeaks(store,file:file,line:line)
        trackForMemoryLeaks(sut,file:file,line:line)
        return (sut, store)
    }
    private func uniqueItem() -> FeedItem {
        FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL())
    }
    private func anyURL() -> URL {
        URL(string: "https://any-url.com")!
    }
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}
