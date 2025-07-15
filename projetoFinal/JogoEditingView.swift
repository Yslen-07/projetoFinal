import SwiftUI
import SwiftData

struct JogoEditingView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State var curso1: String = ""
    @State var curso2: String = ""
    @State var local: String = ""
    @State var data: Date = Date()
    @State var categoria: Categoria = .natacao

    let jogo: Jogo?

    init(jogo: Jogo? = nil) {
        self.jogo = jogo
    }

    var body: some View {
        Form {
            Section(header: Text("Editar o jogo:")) {
                TextField("Curso 1", text: $curso1)
                TextField("Curso 2", text: $curso2)
                TextField("Local", text: $local)

                DatePicker("Data do jogo", selection: $data, displayedComponents: [.date, .hourAndMinute])

                Picker("Categoria", selection: $categoria) {
                    ForEach(Categoria.allCases) { cat in
                        Text(cat.rawValue).tag(cat)
                    }
                }
            }

            Section {
                Button("Salvar alterações") {
                    if let jogo = jogo {
                        jogo.curso1 = curso1
                        jogo.curso2 = curso2
                        jogo.local = local
                        jogo.data = data
                        jogo.categoria = categoria
                    }
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                Button("Deletar jogo"){
                    if let jogo = jogo {
                        modelContext.delete(jogo)
                        
                    }
                    dismiss()
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Editar Jogo")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let jogo = jogo {
                curso1 = jogo.curso1
                curso2 = jogo.curso2
                local = jogo.local
                data = jogo.data
                categoria = jogo.categoria
            }
        }
    }
}
