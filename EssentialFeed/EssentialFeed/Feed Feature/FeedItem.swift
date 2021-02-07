//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 06/02/2021.
//

import Foundation

public struct FeedItem: Equatable {
	let id: UUID
	let description: String?
	let location: String?
	let imageURL: URL
}
