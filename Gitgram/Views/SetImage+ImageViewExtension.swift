//
//  SetImage+ImageViewExtension.swift
//  Gitgram
//
//  Created by Udit Samani on 3/16/19.
//  Copyright © 2019 Udit Samani. All rights reserved.
//

import UIKit


extension UIImageView {
    func setImage(from url: URL){
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            }.resume()
    }
}
