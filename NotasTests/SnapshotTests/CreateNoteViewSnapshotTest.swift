//
//  CreateNoteViewSnapshotTest.swift
//  NotasTests
//
//  Created by Jose Luis Sánchez-Porro on 23/5/24.
//

import XCTest
import SnapshotTesting
@testable import Notas

final class CreateNoteViewSnapshotTest: XCTestCase {

    // El test falla la primera vez pues crea el snapshot 
    func testCreateNoteView() throws {
        let createNoteView = CreateNoteView(viewModel: .init())
        assertSnapshot(of: createNoteView, as: .image)
    }

    func testCreateNoteViewWithData() {
        let createNoteView = CreateNoteView(viewModel: .init(), title: "Snapshot Test", text: "Snapshot Test")
        assertSnapshot(of: createNoteView, as: .image)
    }

}
