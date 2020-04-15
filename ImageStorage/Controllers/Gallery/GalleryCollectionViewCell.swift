//
//  GalleryCollectionViewCell.swift
//  ImageStorage
//
//  Created by Фарид Гулиев on 08.04.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Cell UI Elements
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = Constants.imageContentMode
        return imageView
    }()
    
    
    //MARK: - Constants
    static let cellID: String = "cellID"
    
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowOpacity = Constants.shadowOpacity
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
