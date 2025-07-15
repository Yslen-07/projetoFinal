import SwiftUI
import SwiftData

struct SecFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    //@State private var titulo = ""
    @State private var curso1 = ""
    @State private var curso2 = ""
    @State private var local = ""
    @State private var data = Date()
    @State private var categoriaSelecionada: Categoria = .natacao

    var body: some View {
        NavigationStack {
            Form {
//                Section("Nome do jogo") {
//                    TextField("Título", text: $titulo)
//                }

                Section("Cursos") {
                    TextField("Curso 1", text: $curso1)
                    TextField("Curso 2", text: $curso2)
                }

                Section("Local e Data") {
                    TextField("Local", text: $local)
                    DatePicker("Data", selection: $data)
                }

                Section("Categoria") {
                    Picker("Modalidade", selection: $categoriaSelecionada) {
                        ForEach(Categoria.allCases) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                }

                Button("Salvar") {
                    let novo = Jogo(curso1: curso1, curso2: curso2, categoria: categoriaSelecionada, local: local, data: data)
                    modelContext.insert(novo)
                    dismiss()
                }
            }
            .navigationTitle("Novo Jogo")
        }
    }
}
