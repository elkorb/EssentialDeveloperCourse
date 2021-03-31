//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 01/04/2021.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: (LoadFeedResult) -> Void)
}
