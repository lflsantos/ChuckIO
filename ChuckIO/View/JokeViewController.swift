//
//  ViewController.swift
//  ChuckIO
//
//  Created by Lucas Santos on 01/12/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblJoke: UILabel!

    // MARK: - Properties
    lazy var loadingView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .white
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .orange
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator.startAnimating()
        view.addSubview(indicator)
        indicator.center = view.center
        return view
    }()
    var viewModel: JokeViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showLoadingView(true)
        viewModel?.getJoke()
    }

    // MARK: - Methods
    func showLoadingView(_ show: Bool) {
        show ? self.view.addSubview(loadingView) : loadingView.removeFromSuperview()
    }

    // MARK: - IBActions
    @IBAction func reloadJoke(_ sender: Any) {
        viewModel?.getJoke()
    }
}

extension JokeViewController: JokeViewModelDelegate {
    func updateUI() {
        if let iconUrl = viewModel?.icon {
            ivIcon.imageFromUrl(iconUrl)
        }
        lblJoke.text = viewModel?.jokeText
        title = viewModel?.category.capitalized
        self.showLoadingView(viewModel?.isLoading ?? true)
    }

    func startLoading() {
        showLoadingView(true)
    }
}
