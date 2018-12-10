//
//  API.swift
//  ChuckIO
//
//  Created by Lucas Santos on 02/12/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType: String {
    case random = "random"
    case fromCategory = "random?category="
    case categories = "categories"
    case search = "search?query="
}

enum ErrorType {
    case urlError
    case requestError
    case decodeError
}

class ChuckAPI {
    let baseURL = "https://api.chucknorris.io/jokes/"

    func getCategories(onComplete: @escaping([String]) -> Void, onError: @escaping(ErrorType) -> Void) {
        guard let url = URL(string: baseURL + RequestType.categories.rawValue) else {
            onError(.urlError)
            return
        }
        Alamofire.request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard let data = response.data else {
                    onError(.requestError)
                    return
                }
                do {
                    let categories = try JSONDecoder().decode([String].self, from: data)
                    onComplete(categories)
                } catch {
                    onError(.decodeError)
                    return
                }
        }
    }

    func getJokeFrom(_ category: String, onComplete: @escaping(Joke) -> Void, onError: @escaping(ErrorType) -> Void) {
        guard let url = URL(string: baseURL + RequestType.fromCategory.rawValue + category) else {
            onError(.urlError)
            return
        }

        Alamofire.request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard let data = response.data else {
                    onError(.requestError)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let joke = try decoder.decode(Joke.self, from: data)
                    onComplete(joke)
                } catch {
                    print(error)
                    onError(.decodeError)
                    return
                }
        }
    }
}
