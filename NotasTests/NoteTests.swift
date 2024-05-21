//
//  NotasTests.swift
//  NotasTests
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import XCTest
@testable import Notas

final class NoteTests: XCTestCase {
    
    func testNoteInitialization() {
        // Given or Arrange
        let title = "Test Title"
        let text = "Test Text"
        let date = Date()
        
        // When or Act
        let note = Note(title: title, text: text, createAt: date)
        
        // Then or Assert
        XCTAssertEqual(note.title, title, "Title should be equal to Test Title")
        XCTAssertEqual(note.text, text)
        XCTAssertEqual(note.createAt, date)
    }
    
    func testNoteEmptyText() {
        // Given
        let title = "Test Title"
        let date = Date()
        
        // When
        let note = Note(title: title, text: nil, createAt: date)
        
        // Then
        XCTAssertEqual(note.getText, "")
    }

}
