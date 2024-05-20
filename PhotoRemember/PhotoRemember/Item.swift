//
//  PhotoData.swift
//  PhotoRemember
//
//  Created by Christoph on 20.05.24.
//

import Foundation
import SwiftData
import SwiftUI


@Model
final class Item {
    @Attribute(.externalStorage)
    var image: Data?
    
    init(image: Data) {
            self.image = image
        }
}
