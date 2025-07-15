import SwiftUI
import SwiftData

struct JogoEditingView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var curso1: Curso = .informatica
    @State var curso2: Curso = .edificacoes
    @State var local: String = ""
    @State var data: Date = Date()
    @State var categoria: CategoriaEsportiva = .natacao
    
    let jogo: Jogo?
    
    init(jogo: Jogo? = nil) {
        self.jogo = jogo
    }
    
    var body: some View {
        Form {
            Section(header: Text("Editar o jogo:")) {
                //                TextField("Curso 1", text: $curso1)
                //                TextField("Curso 2", text: $curso2)
                Picker ("Curso 1", selection: $curso1){
                    ForEach(Curso.allCases){ curso in
                        Text(curso.rawValue).tag(curso)
                        
                    }
                }
                Picker ("Curso 2", selection: $curso2){
                    ForEach(Curso.allCases){ curso in
                        Text(curso.rawValue).tag(curso)
                        
                        
                    }
                }
            }
                Section(header: Text("Local e Data")){
                    
                    TextField("Local", text: $local)
                    DatePicker("Data do jogo", selection: $data, displayedComponents: [.date, .hourAndMinute])
                }
                Section(header: Text("Modalidade")){
                    Picker("Modalidade", selection: $categoria) {
                        ForEach(CategoriaEsportiva.allCases) { cat in
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


#Preview {
    JogoEditingView(
        jogo: Jogo(
            curso1: .informatica,
            curso2: .eletrotecnica,
            categoria: .futebol,
            local: "Ginásio",
            data: Date()
        )
    )
    .modelContainer(for: Jogo.self)
}

