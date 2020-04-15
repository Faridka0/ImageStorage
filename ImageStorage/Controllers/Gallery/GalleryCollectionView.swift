//
//  GalleryCollectionView.swift
//  ImageStorage
//
//  Created by Фарид Гулиев on 08.04.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import UIKit
import SDWebImage

final class GalleryCollectionView: UICollectionView {
    
    //MARK: - Constants
    fileprivate var imagesURL: [URL] = []
    
    
    //MARK: - Setup Data
    func set(urls: [URL]?) {
        guard let urls = urls else { return }
        self.imagesURL = urls
        self.reloadData()
    }

    
    //MARK: - Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.cellsMinimumLineSpacing
        super.init(frame: .zero, collectionViewLayout: layout)
        configure()
    }
    
    fileprivate func configure() {
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.cellID)
    }
    
    //MARK: - Functions
    func scrollToFirstItem() {
        UIView.animate(withDuration: 0.3) {
            self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.cellID, for: indexPath) as! GalleryCollectionViewCell
        let url = imagesURL[indexPath.item]
        cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "imageHolder"), options: .progressiveLoad)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellsWidth, height: frame.height)
    }
}
