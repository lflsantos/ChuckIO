//
//  CategoriesTableViewController.swift
//  ChuckIO
//
//  Created by Lucas Santos on 02/12/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    var viewModel: CategoriesViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = CategoriesViewModel(ChuckAPI())
    }

    // MARK: - Actions

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let jokeVC = segue.destination as? JokeViewController,
            let index = self.tableView.indexPathForSelectedRow,
        let category = viewModel?.categories[index.row] {
            jokeVC.viewModel = JokeViewModel(ChuckAPI(), category: category)
        }
    }

}

// MARK: - UITableViewController Delegate and Data Source
extension CategoriesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.categories.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categorieCell"),
            let categories = viewModel?.categories else {
                return UITableViewCell()
        }

        cell.textLabel?.text = categories[indexPath.row]

        return cell
    }
}

// MARK: - View Model Delegate
extension CategoriesTableViewController: CategoriesViewModelDelegate {
    func updateUI() {
        if let  loading = viewModel?.isLoading {
            loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
        tableView.reloadData()
    }
}
