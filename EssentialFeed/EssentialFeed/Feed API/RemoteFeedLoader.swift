//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 07/02/2021.
//

import Foundation

public final class RemoteFeedLoader {
	private let url: URL
	private let client: HTTPClient
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public init(url:URL, client: HTTPClient) {
		self.client = client
		self.url = url
	}
	public func load(completion:@escaping(Error) -> Void) {
		client.get(from:url) { error,response in
			if response != nil {
				completion(.invalidData)
			} else {
				completion(.connectivity)
			}
		}
	}
}


public protocol HTTPClient {
	func get(from url:URL, completion:@escaping (Error?,HTTPURLResponse?)-> Void)
}

