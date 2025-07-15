import SwiftUI
import SwiftData

struct SecFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var curso1: Curso = .informatica
    @State private var curso2: Curso = .edificacoes
    @State private var local: String = ""
    @State private var data: Date = Date()
    @State private var categoriaSelecionada: CategoriaEsportiva = .futebol

    var body: some View {
        NavigationStack {
            Form {
                Section("Cursos") {
                    Picker("Curso 1", selection: $curso1) {
                        ForEach(Curso.allCases) { curso in
                            Text(curso.rawValue).tag(curso)
                        }
                    }

                    Picker("Curso 2", selection: $curso2) {
                        ForEach(Curso.allCases) { curso in
                            Text(curso.rawValue).tag(curso)
                        }
                    }
                }
            
                Section("Local e Data") {
                    TextField("Local", text: $local)
                    DatePicker("Data e Hora", selection: $data, displayedComponents: [.date, .hourAndMinute])
                }

                Section("Modalidade") {
                    Picker("Categoria", selection: $categoriaSelecionada) {
                        ForEach(CategoriaEsportiva.allCases) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                }

                Section {
                    Button("Salvar Jogo") {
                        let novoJogo = Jogo(
                            curso1: curso1,
                            curso2: curso2,
                            categoria: categoriaSelecionada,
                            local: local,
                            data: data
                        )
                        modelContext.insert(novoJogo)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Novo Jogo")
        }
    }
}
