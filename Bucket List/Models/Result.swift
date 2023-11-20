//
//  Result.swift
//  Bucket List
//
//  Created by Vito Borghi on 19/11/2023.
//

import Foundation

struct Result: Codable {
    let query: WikiQuery
}

struct WikiQuery: Codable {
    let pages: [Int:Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < lhs.title
    }
        
}
