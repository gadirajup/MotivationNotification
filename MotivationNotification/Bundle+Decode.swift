//
//  BundleDecoding.swift
//  MotivationNotification
//
//  Created by Prudhvi Gadiraju on 4/16/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from fileName: String) -> T {
        guard let url = url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in app bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName) from app bundle")
        }
        guard let loaded = try? JSONDecoder().decode(type, from: data) else {
            fatalError("Failed to decode \(fileName) from app bundle")
        }
        return loaded
    }
}
