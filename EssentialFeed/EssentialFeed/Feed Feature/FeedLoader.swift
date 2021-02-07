//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 06/02/2021.
//

import Foundation

public enum LoadFeedResult {
	case success([FeedItem])
	case failure(Error)
}

protocol FeedLoader {
	associatedtype Error: Swift.Error
	func load(completion:@escaping (LoadFeedResult)->Void)
}
