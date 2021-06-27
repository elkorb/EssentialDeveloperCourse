//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 25/06/2021.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?)-> Void
    typealias InsertionCompletion = (Error?)-> Void

    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed:[LocalFeedImage],timestamp:Date, completion: @escaping InsertionCompletion)
}
