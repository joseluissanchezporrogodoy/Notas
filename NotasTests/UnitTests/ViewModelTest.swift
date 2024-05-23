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
        viewModel = ViewModel(createNoteUseCase: CreateNoteUseCaseMock(),
                              fetchAllNotesUseCase: FetchAllNotesUseCaseMock(),
                              updateNoteUseCase: UpdateNotesUseCaseMock(),
                              removeNoteUseCase: RemoveNoteUseCaseMock())
    }
    
    override func tearDownWithError() throws {
       mockDatabase = []
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
        let title = "Original Title"
        let text = "Original Text"
        viewModel.createNoteWith(title: title, text: text)
        
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
        let title = "Original Title"
        let text = "Original Text"
        viewModel.createNoteWith(title: title, text: text)
        
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
