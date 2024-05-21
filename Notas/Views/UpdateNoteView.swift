//
//  UpdateNoteView.swift
//  Notas
//
//  Created by Jose Luis Sánchez-Porro on 21/5/24.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: ViewModel
    let id: UUID
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Texto"), axis: .vertical)
                } footer: {
                    Text("* El título es obligatorio")
                }
            }
            Button {
                viewModel.removeNoteWith(id: id)
                dismiss()
            } label: {
                Text("Eliminar Nota")
                    .foregroundStyle(.gray)
                    .underline()
            }
            .buttonStyle(BorderlessButtonStyle())
            Spacer()

          
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.updateNoteWith(id: id, newTitle: title, newText: text)
                    dismiss()
                } label: {
                    Text("Guardar Nota")
                        .bold()
                }
            }
        }
        .navigationTitle("Modificar nota")
    }
}

#Preview {
    NavigationStack {
        UpdateNoteView(viewModel: .init(), id: .init(), title: "Suscribete a la leche", text: "Que si que no que nunca te decides")
    }
}
