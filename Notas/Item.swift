//
//  Item.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
