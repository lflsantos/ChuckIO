//
//  CategoriesViewModelTests.swift
//  ChuckIOTests
//
//  Created by Lucas Santos on 09/12/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import XCTest
@testable import ChuckIO

class CategoriesViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUppercaseLetters() {
        let categories = ["movie", "celebrity", "explicit"]
        let captalizeCategories = ["Movie", "Celebrity", "Explicit"]
        let viewModel = CategoriesViewModel(ChuckAPI())

         let testCaptalized = viewModel.captalizeStrings(categories)

        XCTAssertEqual(captalizeCategories, testCaptalized)
    }
}
