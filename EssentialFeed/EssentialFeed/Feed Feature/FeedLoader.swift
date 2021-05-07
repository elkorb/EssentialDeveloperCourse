//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 01/04/2021.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
