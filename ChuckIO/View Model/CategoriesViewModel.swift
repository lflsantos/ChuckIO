//
//  CategoriesViewModel.swift
//  ChuckIO
//
//  Created by Lucas Santos on 02/12/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

protocol CategoriesViewModelDelegate: class {
    func updateUI()
}

public class CategoriesViewModel {

    // MARK: - Properties
    var service: ChuckAPI
    private var categories: [String] = []
    var numberOfCells: Int {
        return categories.count
    }
    var isLoading = false

    weak var delegate: CategoriesViewModelDelegate?

    // MARK: - Methods
    init(_ service: ChuckAPI) {
        self.service = service

        self.populateCategories()
    }

    func populateCategories() {
        ChuckAPI().getCategories(onComplete: { [weak self] (categories) in
            self?.categories = categories
            self?.delegate?.updateUI()
            }, onError: { (_) in
        })
    }

    func getCategoryAt(_ index: Int, captalized: Bool) -> String {
        return captalized ? captalizeStrings(categories)[index] : categories[index]
    }

    func captalizeStrings(_ strings: [String]) -> [String] {
        return strings.map({ $0.capitalized })
    }
}
