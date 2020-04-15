//
//  FirebaseStorageService.swift
//  ImageStorage
//
//  Created by Фарид Гулиев on 08.04.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import Foundation
import Firebase


//func upload(image: UIImage, name: String) {
//    guard let data = image.jpegData(compressionQuality: 1) else { return }
//    let imageRef = folderRef.child("\(name)")
//
//    imageRef.putData(data, metadata: nil) { (metadata, error) in
//        guard error == nil else { return }
//        guard metadata != nil else { return }
//    }
//}

final class FirebaseStorageService {
    fileprivate let folderRef = Storage.storage().reference().child("images")
    fileprivate let dispatchGroup = DispatchGroup()
    fileprivate let dispatchQueue = DispatchQueue(label: "com.gulfar.firebase", qos: .utility)
    
    
    func upload(image: UIImage, imageName: String, completion: @escaping ((URL?) -> ())) {
        let imageRef = folderRef.child(imageName)
        if let imageData = image.jpegData(compressionQuality: 1) {
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard error == nil else {
                    completion(nil)
                    return
                }
                self.getDownloadURL(ref: imageRef) { (url) in
                    guard let url = url else {
                        completion(nil)
                        return
                    }
                    completion(url)
                }
                
            }
        }
    }
    
    func load(completion: @escaping ([URL]?) -> ()) {
        var urls: [URL] = []
        listAll { (itemsRef) in
            guard let itemsRef = itemsRef else {
                completion(nil)
                return
            }
            
            itemsRef.forEach {
                self.getDownloadURL(ref: $0) { (url) in
                    guard let url = url else { return }
                    urls.append(url)
                }
            }
            self.dispatchGroup.notify(queue: .main) {
                completion(urls.count == 0 ? nil : urls)
            }
            
        }
    }
    
    fileprivate func getDownloadURL(ref: StorageReference, completion: @escaping ((URL?) -> ())) {
        self.dispatchGroup.enter()
        self.dispatchQueue.async(group: self.dispatchGroup) {
            ref.downloadURL { (url, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    completion(nil)
                    self.dispatchGroup.leave()
                    return
                }
                completion(url)
                self.dispatchGroup.leave()
            }
        }
    }
    
    fileprivate func listAll(completion: @escaping (([StorageReference]?) -> ())) {
        self.folderRef.listAll { (result, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            completion(result.items)
        }
    }
}
