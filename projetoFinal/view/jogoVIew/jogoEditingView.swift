import SwiftUI
import SwiftData

struct JogoEditingView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var jogo: Jogo   // binding direto com SwiftData
    
    var body: some View {
        Form {
            Section("Cursos") {
                Picker("Curso 1", selection: $jogo.curso1) {
                    ForEach(Curso.allCases) { c in Text(c.rawValue).tag(c) }
                }
                Picker("Curso 2", selection: $jogo.curso2) {
                    ForEach(Curso.allCases) { c in Text(c.rawValue).tag(c) }
                }
            }
            
            Section("Local e Data") {
                TextField("Local", text: $jogo.local)
                DatePicker("Data", selection: $jogo.data, displayedComponents: [.date, .hourAndMinute])
            }
            
            Section("Modalidade") {
                Picker("Categoria", selection: $jogo.categoria) {
                    ForEach(CategoriaEsportiva.allCases) { cat in Text(cat.rawValue).tag(cat) }
                }
                Picker("Gênero", selection: $jogo.genero) {
                    ForEach(Genero.allCases) { g in Text(g.rawValue).tag(g) }
                }
            }
            
            Section("Placar") {
                TextField("Placar do \(jogo.curso1.rawValue)", text: $jogo.placar1)
                TextField("Placar do \(jogo.curso2.rawValue)", text: $jogo.placar2)
            }
            
            Section {
                Button("Salvar") { dismiss() } // binding já atualiza o jogo
                Button("Cancelar") { dismiss() }
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Editar Jogo")
    }
}
