//
//  Constants.swift
//  ImageStorage
//
//  Created by Фарид Гулиев on 15.04.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import UIKit

struct Constants {
    static let leadingSpacing: CGFloat = 24.0
    static let traillingSpacing: CGFloat = 24.0
    
    //Gallery Cell
    static let cellsMinimumLineSpacing: CGFloat = 8.0
    static let cellsWidth: CGFloat = (UIScreen.main.bounds.width - Constants.leadingSpacing - Constants.traillingSpacing - Constants.cellsMinimumLineSpacing / 2) / 2
    static let imageContentMode: UIView.ContentMode = .scaleAspectFit
    
    //Shadow
    static let shadowRadius: CGFloat = 9
    static let shadowOffset: CGSize = .init(width: 6, height: 9)
    static let shadowOpacity: Float = 0.3
}
