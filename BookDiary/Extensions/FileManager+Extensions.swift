//
//  FileManager+Extensions.swift
//  BookDiary
//
//  Created by Quien on 2022/12/7.
//

import Foundation

extension FileManager {

  static func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }

  static func pathToDoucumentsDirectory(with fileName: String, pathExtension: String = "plist") -> URL {
    return getDocumentsDirectory().appendingPathComponent(fileName).appendingPathExtension(pathExtension)
  }
  
  static func getImagesDirectory() -> URL {
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let imageURL = documentURL.appendingPathComponent("images")
    if !FileManager.default.fileExists(atPath: imageURL.path) {
      try? FileManager.default.createDirectory(atPath: imageURL.path, withIntermediateDirectories: true, attributes: nil)
    }
    return imageURL
  }
  
  static func pathToImagesDirectory(with imageName: String) -> URL {
    return getImagesDirectory().appendingPathComponent(imageName)
  }
}
