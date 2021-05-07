//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 01/04/2021.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: (LoadFeedResult<Error>) -> Void)
}
