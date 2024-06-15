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
class Item {
    
    var descript: String
    
    @Attribute(.externalStorage)
    var image: Data?
    
    init(descript: String = "", image: Data? = nil) {
        self.descript = descript
        self.image = image
    }
}
