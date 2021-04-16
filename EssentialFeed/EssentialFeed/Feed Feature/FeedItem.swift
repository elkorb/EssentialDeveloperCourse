//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 01/04/2021.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
