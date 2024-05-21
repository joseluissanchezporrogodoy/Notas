//
//  Note.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import Foundation
import SwiftData

@Model
class Note: Identifiable, Hashable {
    @Attribute(.unique)  var identifier: UUID
    var title: String
    var text: String?
    var createAt: Date
    
    var getText: String {
        text ?? ""
    }
    
    init(identifier: UUID = UUID(), title: String, text: String?, createAt: Date) {
        self.identifier = identifier
        self.title = title
        self.text = text
        self.createAt = createAt
    }
}
