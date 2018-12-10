//
//  Joke.swift
//  ChuckIO
//
//  Created by Lucas Santos on 02/12/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

struct Joke: Decodable {
    let category: [String]?
    let iconUrl: String?
    let url: String?
    let value: String?
}
