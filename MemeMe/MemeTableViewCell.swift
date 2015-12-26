//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Jose Piñero on 12/26/15.
//  Copyright © 2015 José Piñero. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeTexts: UILabel!
    @IBOutlet weak var memeImage: UIImageView!
    
    func setUp(meme: Meme) {
        memeTexts.text = meme.topText + " " + meme.bottomText
        memeImage.image = meme.memedImage
    }
}