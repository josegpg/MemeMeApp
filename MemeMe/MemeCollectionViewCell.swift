//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Jose Piñero on 12/26/15.
//  Copyright © 2015 José Piñero. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImage: UIImageView!
    
    func setUp(meme: Meme) {
        memeImage.image = meme.memedImage
    }
}