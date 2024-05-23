//
//  NotasUITests.swift
//  NotasUITests
//
//  Created by Jose Luis Sánchez-Porro on 23/5/24.
//

import XCTest

final class NotasUITests: XCTestCase {
    
    func testCreateNote() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear Nota"]/*[[".otherElements[\"Crear Nota\"]",".buttons[\"Crear Nota\"].staticTexts[\"Crear Nota\"]",".staticTexts[\"Crear Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        let titleTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView.tap()
        titleTextView.typeText("Título Nota Nueva")
        
        let textTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textTextView.tap()
        textTextView.typeText("Nuevo Texto")
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear Nota"]/*[[".otherElements[\"Crear Nota\"].buttons[\"Crear Nota\"]",".buttons[\"Crear Nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
              
    }
    
    func testCreateTwoNotes() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear Nota"]/*[[".otherElements[\"Crear Nota\"]",".buttons[\"Crear Nota\"].staticTexts[\"Crear Nota\"]",".staticTexts[\"Crear Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        
        // Creamos primera nota
        let titleTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView.tap()
        titleTextView.typeText("Título Nota Nueva")
        
        let textTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textTextView.tap()
        textTextView.typeText("Nuevo Texto")
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear Nota"]/*[[".otherElements[\"Crear Nota\"].buttons[\"Crear Nota\"]",".buttons[\"Crear Nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        // Creamos segunda nota
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear Nota"]/*[[".otherElements[\"Crear Nota\"]",".buttons[\"Crear Nota\"].staticTexts[\"Crear Nota\"]",".staticTexts[\"Crear Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let titleTextView2 = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView2.tap()
        titleTextView2.typeText("Título Nota Nueva2")
        
        let textTextView2 = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textTextView2.tap()
        textTextView2.typeText("Nuevo Texto2")
        
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear Nota"]/*[[".otherElements[\"Crear Nota\"].buttons[\"Crear Nota\"]",".buttons[\"Crear Nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testRemoveNote() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear Nota"]/*[[".otherElements[\"Crear Nota\"]",".buttons[\"Crear Nota\"].staticTexts[\"Crear Nota\"]",".staticTexts[\"Crear Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        
        // Creamos primera nota
        let titleTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView.tap()
        titleTextView.typeText("Título Nota Nueva")
        
        let textTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textTextView.tap()
        textTextView.typeText("Nuevo Texto")
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear Nota"]/*[[".otherElements[\"Crear Nota\"].buttons[\"Crear Nota\"]",".buttons[\"Crear Nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        // Creamos segunda nota
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear Nota"]/*[[".otherElements[\"Crear Nota\"]",".buttons[\"Crear Nota\"].staticTexts[\"Crear Nota\"]",".staticTexts[\"Crear Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let titleTextView2 = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView2.tap()
        titleTextView2.typeText("Título Nota Nueva2")
        
        let textTextView2 = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textTextView2.tap()
        textTextView2.typeText("Nuevo Texto2")
        
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear Nota"]/*[[".otherElements[\"Crear Nota\"].buttons[\"Crear Nota\"]",".buttons[\"Crear Nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let firstNote = collectionViewsQuery.cells.element(boundBy: 0)
        firstNote.tap()
        
        app.buttons.matching(identifier: "remove_button_identifier").element.tap()
        
    }
}
