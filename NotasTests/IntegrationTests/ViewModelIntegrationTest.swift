//
//  ViewModelIntegrationTest.swift
//  NotasTests
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import XCTest
@testable import Notas

@MainActor
final class ViewModelIntegrationTest: XCTestCase {
    
    var sut: ViewModel!
    
    override func setUpWithError() throws {
        let dataBase = NotesDatabase.shared
        dataBase.contairner = NotesDatabase.setupContainer(inMemory: true)
        
        let createNotesUseCase = CreateNoteUseCase(notesDataBase: dataBase)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDataBase: dataBase)
        
        sut = ViewModel(createNoteUseCase: createNotesUseCase,
                        fetchAllNotesUseCase: fetchAllNotesUseCase)
    }

    override func tearDownWithError() throws {
        
    }
    
    func testCreateNote() {
        // Given
        sut.createNoteWith(title: "Nota 1", text: "Text 1")
        
        // When
        let note = sut.notes.first
        
        
        // Then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "Nota 1")
        XCTAssertEqual(note?.text, "Text 1")
        XCTAssertEqual(sut.notes.count, 1, "Deberia haber 1")
    }
    
    func testCreateTwoNote() {
        // Given
        sut.createNoteWith(title: "Nota 1", text: "Text 1")
        sut.createNoteWith(title: "Nota 2", text: "Text 2")
        
        // When
        let firstNote = sut.notes.first
        let lastNote = sut.notes.last
        
        
        // Then
        XCTAssertNotNil(firstNote)
        XCTAssertEqual(firstNote?.title, "Nota 1")
        XCTAssertEqual(firstNote?.text, "Text 1")
        
        XCTAssertNotNil(lastNote)
        XCTAssertEqual(lastNote?.title, "Nota 2")
        XCTAssertEqual(lastNote?.text, "Text 2")
        
        
        XCTAssertEqual(sut.notes.count, 2, "Deberia haber 2")
    }
    
    func testFetchAllNotes() {
        // Given
        sut.createNoteWith(title: "Nota 1", text: "Text 1")
        sut.createNoteWith(title: "Nota 2", text: "Text 2")
        
        // When
        let firstNote = sut.notes.first
        let lastNote = sut.notes.last
        
        // Then
        XCTAssertEqual(sut.notes.count, 2)
        XCTAssertEqual(firstNote?.title, "Nota 1")
        XCTAssertEqual(firstNote?.text, "Text 1")
        
        XCTAssertNotNil(lastNote)
        XCTAssertEqual(lastNote?.title, "Nota 2")
        XCTAssertEqual(lastNote?.text, "Text 2")
        
    }
    
    func testUpdateNote() {
        // Given
        sut.createNoteWith(title: "Note 1", text: "Text 1")
        
        // When
        guard let note = sut.notes.first else {
            XCTFail()
            return
        }
        
        // Them
        sut.updateNoteWith(identifier: note.identifier, newTitle: "Jose", newText: "Jose")
        sut.fetchAllNotes()
        
        XCTAssertEqual(sut.notes.count, 1, "Debería haber 1 nota")
        XCTAssertEqual(sut.notes[0].title, "Jose")
        XCTAssertEqual(sut.notes[0].text, "Jose")
    }
    
    func testRemoveNote() {
        // Given
        sut.createNoteWith(title: "Nota 1", text: "Text 1")
        sut.createNoteWith(title: "Nota 2", text: "Text 2")
        
        guard let note = sut.notes.last else  {
            XCTFail()
            return
        }
        
        sut.removeNoteWith(identifier: note.identifier)
        XCTAssertEqual(sut.notes.count, 1, "Debería haber 1 nota")
        XCTAssertEqual(sut.notes[0].title, "Nota 1")
        XCTAssertEqual(sut.notes[0].text, "Text 1")
    }
    
    func testRemoveNoteIndatabaseShouldThrowError() {
        // Given
        sut.removeNoteWith(identifier: UUID())
        
        XCTAssertEqual(sut.notes.count, 0)
        XCTAssertNotNil(sut.databaseError)
        XCTAssertEqual(sut.databaseError, DataBaseError.errorRemove)
    }
}
