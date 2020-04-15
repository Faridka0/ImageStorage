//
//  MainViewController.swift
//  ImageStorage
//
//  Created by Фарид Гулиев on 08.04.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet fileprivate var uploadImageButton: UIButton!
    
    
    //MARK: - UI Elements
    fileprivate let galleryCollectionView = GalleryCollectionView()
    
    
    //MARK: - Services
    fileprivate let firebaseService = FirebaseStorageService()
    
    
    //MARK: - Constants
    var urls: [URL]? {
        didSet {
            galleryCollectionView.set(urls: urls)
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupGalleryCollectionView()
    }
    
    
    //MARK: - Setup UI Elements
    fileprivate func setupGalleryCollectionView() {
        view.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        galleryCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    //MARK: - Private Functions
    fileprivate func loadData() {
        firebaseService.load { self.urls = $0 }
    }
    
    fileprivate func showAlert(with title: String) {
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertVC, animated: true)
    }
    
    
    //MARK: - IBActions
    @IBAction func uploadImageButtonPressed(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
}


//MARK : - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        defer { dismiss(animated: true) }
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        guard let pickedImageName = (info[.imageURL] as? NSURL)?.lastPathComponent else { return }
        firebaseService.upload(image: pickedImage, imageName: pickedImageName) { (url) in
            guard let url = url else { return }
            self.urls?.insert(url, at: 0)
            self.galleryCollectionView.scrollToFirstItem()
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
