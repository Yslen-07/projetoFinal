import SwiftUI
import SwiftData

struct JogoEditingView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State var curso1 : String = ""
    @State var curso2 : String = ""
    @State var local: String = ""
    @State var data: Date = Date()
    @State var JogoCategoria: Categoria = .natacao

    let jogo: Jogo?

    init(jogo: Jogo? = nil) {
        self.jogo = jogo
    }

    var body: some View {
        Form {
            Section(header: Text("Editar o jogo:")) {
                TextField("Curso1", text: $curso1)
                TextField("Curso2", text: $curso2)
                TextField("Local", text: $local)
                
                DatePicker("Data do Jogo", selection: $data, displayedComponents: [.date, .hourAndMinute])
                
                Picker("Categoria", selection: $JogoCategoria) {
                    ForEach(Categoria.allCases) { cat in
                        Text(cat.rawValue).tag(cat)
                    }
                }
            }
        }
        .onAppear {
            if let jogo = jogo {
                curso1 = jogo.curso1
                curso2 = jogo.curso2
                local = jogo.local
                data = jogo.data
                JogoCategoria = jogo.categoria
            }
        }
        .navigationTitle("Editar Jogo")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Voltar") {
                    dismiss()
                }
                .tint(.red)
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    if let jogo = jogo {
                        jogo.curso1 = curso1
                        jogo.curso2 = curso2
                        jogo.local = local
                        jogo.data = data
                        jogo.categoria = JogoCategoria
                    }
                    dismiss()
                }
                .tint(.blue)
            }
        }
    }
}

#Preview {
    JogoEditingView(jogo: Jogo(
    
        curso1: "Informática",
        curso2: "Tele",
        categoria: .natacao,
        local: "Ginásio",
        data: Date()
    ))
}
