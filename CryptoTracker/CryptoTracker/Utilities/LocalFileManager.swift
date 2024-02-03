//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Ahmed Fathi on 23/12/2023.
//

import Foundation
import SwiftUI



class LocalFileManager {
    
    
    static let instance = LocalFileManager()
    
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        
        // get path for image
        guard let data = image.pngData(), let url = getURLForImage(imageName: imageName, folderName: folderName) else { return}
        
        
        // save image to path
        do {
            try data.write(to: url)
            
        } catch let error {
            print("error saving image. \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName:String , folderName: String) -> UIImage?{
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {return nil}
        return UIImage(contentsOfFile: url.path)
        
        
    }
    
    private func createFolderIfNeeded(folderName: String) {
        
        guard let url = getURLForFolder(FolderNmae: folderName) else { return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating directory \(error.localizedDescription)")
            }
        }
        
    }
    
    private func getURLForFolder(FolderNmae: String) -> URL? {
        
        guard  let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        
        return url.appendingPathComponent(FolderNmae)
    }
    
    private func getURLForImage(imageName: String , folderName: String) -> URL? {
        guard  let folderURL = getURLForFolder(FolderNmae: folderName) else { return nil}
        
        
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
    
}
