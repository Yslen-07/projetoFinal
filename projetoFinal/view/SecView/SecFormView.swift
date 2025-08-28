import SwiftUI
import SwiftData

struct SecFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var curso1: Curso = .informatica
    @State private var curso2: Curso = .edificacoes
    @State private var local: String = ""
    @State private var data: Date = Date()
    @State private var categoriaSelecionada: CategoriaEsportiva = .volei
    @State private var genero: Genero = .mulher
    @State private var placar1: String = ""
    @State private var placar2: String = ""
    
    // Campos específicos para natação
    @State private var estiloDeNado: EstiloDeNado = .costa
    @State private var quantidadePessoas: String = ""
    @State private var distancia: String = ""
    @State private var tempo: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Modalidade") {
                    Picker("Categoria", selection: $categoriaSelecionada) {
                        ForEach(CategoriaEsportiva.allCases) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                    
                    Picker("Gênero", selection: $genero) {
                        ForEach(Genero.allCases) { genero in
                            Text(genero.rawValue).tag(genero)
                        }
                    }
                    
                    // Campos específicos para natação
                    if categoriaSelecionada == .natacao {
                        Picker("Estilo de nado", selection: $estiloDeNado) {
                            ForEach(EstiloDeNado.allCases) { nado in
                                Text(nado.rawValue).tag(nado)
                            }
                        }
                    }
                }
                
                // Seção de cursos (apenas para esportes que não são natação)
                if categoriaSelecionada != .natacao {
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
                    
                    Section("Placar") {
                        TextField("Digite o placar de \(curso1.rawValue)", text: $placar1)
                        TextField("Digite o placar de \(curso2.rawValue)", text: $placar2)
                    }
                } else {
                    // Campos específicos para natação
                    Section("Participantes") {
                        TextField("Número de participantes", text: $quantidadePessoas)
                            .keyboardType(.numberPad)
                    }
                    
                    Section("Distância") {
                        TextField("Distância (metros)", text: $distancia)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section("Local e Data") {
                    TextField("Local", text: $local)
                    DatePicker("Data e Hora", selection: $data, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section {
                    Button("Salvar Jogo") {
                        if categoriaSelecionada == .natacao {
                            // Salvar como natação
                            let novoJogoNatacao = JogoNatacao(
                                categoria: categoriaSelecionada,
                                estiloDeNado: estiloDeNado,
                                genero: genero,
                                local: local,
                                data: data,
                                quantidadePessoas: quantidadePessoas,
                                distancia: distancia
                            )
                            modelContext.insert(novoJogoNatacao)
                        } else {
                            // Salvar como jogo normal
                            let novoJogo = Jogo(
                                curso1: curso1,
                                curso2: curso2,
                                categoria: categoriaSelecionada,
                                genero: genero,
                                local: local,
                                data: data,
                                placar1: placar1,
                                placar2: placar2
                            )
                            modelContext.insert(novoJogo)
                        }
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Cancelar") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Novo Jogo")
        }
    }
}

#Preview {
    SecFormView()
        .modelContainer(for: [Jogo.self, JogoNatacao.self], inMemory: true)
}
