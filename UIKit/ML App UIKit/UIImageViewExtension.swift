//
//  UIImageViewExtension.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 22/11/22.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL?, completion: (() -> Void)? = nil) {
        guard let url = url else {
            return
        }
        URLSession.shared.dataTask(with: .init(url: url)) { data, _, _ in
            if let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    completion?()
                }
            }
        }
        .resume()
    }
 
    var aspectRatio: CGFloat {
        guard let image = self.image,
              image.size.width > 0 else {
            return 0
        }
        return image.size.height / image.size.width
    }
    
    
}
