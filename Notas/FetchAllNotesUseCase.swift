//
//  FetchAllNotesUseCase.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import Foundation

struct FetchAllNotesUseCase {
    var notesDataBase: NotesDatabaseProtocol
    
    init(notesDataBase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDataBase = notesDataBase
    }
    
    func fetchAll() throws -> [Note] {
        try notesDataBase.fetchAll()
    }
}
