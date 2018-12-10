//
//  JokeViewModel.swift
//  ChuckIO
//
//  Created by Lucas Santos on 02/12/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation
import UIKit

protocol JokeViewModelDelegate: class {
    func updateUI()
    func startLoading()
}

public class JokeViewModel {

    // MARK: - Properties
    var service: ChuckAPI
    var category: String
    var isLoading = true {
        didSet {
            if isLoading {
                delegate?.startLoading()
            }
        }
    }
    var joke: Joke? {
        didSet {
            guard let text = joke?.value,
                let iconUrl = joke?.iconUrl else {
                    return
            }
            self.jokeText = text
            self.icon = iconUrl
        }
    }
    var jokeText = ""
    var icon = ""

    weak var delegate: JokeViewModelDelegate?

    // MARK: - Methods
    init(_ service: ChuckAPI, category: String) {
        self.service = service
        self.category = category
    }

    func getJoke() {
        isLoading = true
        service.getJokeFrom(category, onComplete: { [weak self] (joke) in
            self?.joke = joke
            self?.isLoading = false
            self?.delegate?.updateUI()
        }, onError: { (_) in
        })
    }
}
