//
//  ViewModelTest.swift
//  NotasTests
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import XCTest
@testable import Notas // Se añade para poder probar las clases "internal"

@MainActor
final class ViewModelTest: XCTestCase {
    var viewModel: ViewModel!
    
    override func setUpWithError() throws {
        let dataBase = NotesDatabase.shared
        dataBase.contairner = NotesDatabase.setupContainer(inMemory: true)
        
        let createNotesUseCase = CreateNoteUseCase(notesDataBase: dataBase)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDataBase: dataBase)
        
        viewModel = ViewModel(createNoteUseCase: createNotesUseCase,
                              fetchAllNotesUseCase: fetchAllNotesUseCase)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    func testCreateNote() {
        // Given
        let title = "Test Title"
        let text = "Test Text"
        
        // When
        viewModel.createNoteWith(title: title, text: text)
        
        // Then
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
    }
    
    func testCreateThreeNotes() {
        // Given
        let title1 = "Test Title 1"
        let text1 = "Test Text 1"
        
        let title2 = "Test Title 2"
        let text2 = "Test Text 2"
        
        let title3 = "Test Title 3"
        let text3 = "Test Text 3"
        
        // When
        viewModel.createNoteWith(title: title1, text: text1)
        viewModel.createNoteWith(title: title2, text: text2)
        viewModel.createNoteWith(title: title3, text: text3)
        
        // Then
        XCTAssertEqual(viewModel.notes.count, 3)
        XCTAssertEqual(viewModel.notes.first?.title, title1)
        XCTAssertEqual(viewModel.notes.first?.text, text1)
        XCTAssertEqual(viewModel.notes[1].title, title2)
        XCTAssertEqual(viewModel.notes[1].text, text2)
        XCTAssertEqual(viewModel.notes[2].title, title3)
        XCTAssertEqual(viewModel.notes[2].text, text3)
        
    }
    
    func testUpdateNoteWith() {
        // Given
        let note = Note(title: "Original Title", text: "Original Text", createAt: .now)
        viewModel.notes.append(note)
        
        guard let noteId = viewModel.notes.first?.identifier else {
            XCTFail("Note ID should not be nil")
            return
        }
        
        // When
        viewModel.updateNoteWith(identifier: noteId, newTitle: "Updated Title", newText: "Updated Text")
        
        // Then
        XCTAssertEqual(viewModel.notes.first?.title, "Updated Title")
        XCTAssertEqual(viewModel.notes.first?.text, "Updated Text")
    }
    
    func testRemoveNoteWith() {
        // Given
        let note = Note(title: "Title to Remove", text: "Text to Remove", createAt: .now)
        viewModel.notes.append(note)
        
        guard let noteId = viewModel.notes.first?.identifier else {
            XCTFail("Note ID should not be nil")
            return
        }
        // When
        viewModel.removeNoteWith(identifier: noteId)
        // Then
        XCTAssertTrue(viewModel.notes.isEmpty)
    }
    
}
