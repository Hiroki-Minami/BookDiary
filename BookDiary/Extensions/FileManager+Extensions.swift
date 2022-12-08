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
}
