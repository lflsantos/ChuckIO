//
//  UIImage.swift
//  ChuckIO
//
//  Created by Lucas Santos on 09/12/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    func imageFromUrl(_ urlString: String) {
        Alamofire.request(urlString, method: .get).response(completionHandler: ({ (response) in
            if let data = response.data {
                self.image = UIImage(data: data)
            }
        }))
    }
}
