//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 01/04/2021.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
