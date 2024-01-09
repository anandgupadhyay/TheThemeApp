//
//  Theme.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 03/01/24.
//

import Foundation

struct Category: Codable {
    let id: Int
    let title: String
    let themes: [Theme]
    
}
struct Theme: Codable {
    let id: Int
    let title: String
    let url: String
    let category: String
    let description: String
}

