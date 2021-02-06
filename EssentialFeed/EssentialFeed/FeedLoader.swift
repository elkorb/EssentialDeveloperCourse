//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 06/02/2021.
//

import Foundation

enum LoadFeedResult {
	case success([FeedItem])
	case failure(Error)
}

protocol FeedLoader {
	func load(completion:@escaping (LoadFeedResult)->Void)
}
