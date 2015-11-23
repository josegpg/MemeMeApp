//
//  Meme.swift
//  MemeMe
//
//  Created by Jose Piñero on 11/22/15.
//  Copyright © 2015 José Piñero. All rights reserved.
//

import UIKit

class Meme: NSObject {
    
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(upText: String, downText: String, image: UIImage, meme: UIImage) {
        topText = upText
        bottomText = downText
        originalImage = image
        memedImage = meme
    }
}
