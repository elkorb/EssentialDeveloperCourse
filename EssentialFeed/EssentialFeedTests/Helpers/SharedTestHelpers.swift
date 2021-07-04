//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Elkana Orbach on 04/07/2021.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}
