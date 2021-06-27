//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Elkana Orbach on 27/06/2021.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
