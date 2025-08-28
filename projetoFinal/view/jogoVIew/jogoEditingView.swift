import SwiftUI
import SwiftData

struct JogoEditingView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let jogoParaEditar: Jogo?
    let jogoNatacaoParaEditar: JogoNatacao?
    
    @State private var curso1: Curso = .informatica
    @State private var curso2: Curso = .edificacoes
    @State private var local: String = ""
    @State private var data: Date = Date()
    @State private var categoria: CategoriaEsportiva = .volei
    @State private var genero: Genero = .mulher
    @State private var placar1: String = ""
    @State private var placar2: String = ""
    
    // Campos específicos para natação
    @State private var estiloDeNado: EstiloDeNado = .costa
    @State private var quantidadePessoas: String = ""
    @State private var distancia: String = ""
    @State private var tempo: String = ""
    
    // No JogoEditingView, você deve ter:
    init(jogo: Jogo? = nil) {
        self.jogoParaEditar = jogo
        self.jogoNatacaoParaEditar = nil
    }

    init(jogoNatacao: JogoNatacao? = nil) {
        self.jogoParaEditar = nil
        self.jogoNatacaoParaEditar = jogoNatacao
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Modalidade") {
                    Picker("Categoria", selection: $categoria) {
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
                    if categoria == .natacao {
                        Picker("Estilo de nado", selection: $estiloDeNado) {
                            ForEach(EstiloDeNado.allCases) { nado in
                                Text(nado.rawValue).tag(nado)
                            }
                        }
                    }
                }
                
                // Seção de cursos (apenas para esportes que não são natação)
                if categoria != .natacao {
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
                        TextField("Placar do \(curso1.rawValue)", text: $placar1)
                            .keyboardType(.numberPad)
                        TextField("Placar do \(curso2.rawValue)", text: $placar2)
                            .keyboardType(.numberPad)
                    }
                } else {
                    // Campos específicos para natação
                    Section("Participantes") {
                        TextField("Número de participantes", text: $quantidadePessoas)
                            .keyboardType(.numberPad)
                    }
                    
                    Section("Tempo e Distância") {
                        TextField("Tempo (ex: 2min30s)", text: $tempo)
                        TextField("Distância (metros)", text: $distancia)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section("Local e Data") {
                    TextField("Local", text: $local)
                    DatePicker("Data e Hora", selection: $data, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section {
                    Button("Salvar") {
                        salvarJogo()
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
                    
                    if jogoParaEditar != nil || jogoNatacaoParaEditar != nil {
                        Button("Deletar") {
                            deletarJogo()
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .navigationTitle(jogoParaEditar != nil || jogoNatacaoParaEditar != nil ? "Editar Jogo" : "Novo Jogo")
            .onAppear {
                
                if let jogo = jogoParaEditar {
                    curso1 = jogo.curso1
                    curso2 = jogo.curso2
                    local = jogo.local
                    data = jogo.data
                    categoria = jogo.categoria
                    genero = jogo.genero
                    placar1 = jogo.placar1
                    placar2 = jogo.placar2
                } else if let natacao = jogoNatacaoParaEditar {
                    local = natacao.local
                    data = natacao.data
                    categoria = natacao.categoria
                    genero = natacao.genero
                    estiloDeNado = natacao.estiloDeNado
                    quantidadePessoas = natacao.quantidadePessoas
                    distancia = natacao.distancia
                    tempo = natacao.tempo
                }
            }
        }
    }
    
    private func salvarJogo() {
        if categoria == .natacao {
            if let jogoExistente = jogoNatacaoParaEditar {
                // Atualizar jogo existente
                jogoExistente.local = local
                jogoExistente.data = data
                jogoExistente.categoria = categoria
                jogoExistente.genero = genero
                jogoExistente.estiloDeNado = estiloDeNado
                jogoExistente.quantidadePessoas = quantidadePessoas
                jogoExistente.distancia = distancia
                jogoExistente.tempo = tempo
            } else {
                // Criar novo jogo
                let novoJogo = JogoNatacao(
                    categoria: categoria,
                    estiloDeNado: estiloDeNado,
                    genero: genero,
                    local: local,
                    data: data,
                    quantidadePessoas: quantidadePessoas,
                    distancia: distancia,
                    tempo: tempo
                )
                modelContext.insert(novoJogo)
            }
        } else {
            if let jogoExistente = jogoParaEditar {
                // Atualizar jogo existente
                jogoExistente.curso1 = curso1
                jogoExistente.curso2 = curso2
                jogoExistente.local = local
                jogoExistente.data = data
                jogoExistente.categoria = categoria
                jogoExistente.genero = genero
                jogoExistente.placar1 = placar1
                jogoExistente.placar2 = placar2
            } else {
                // Criar novo jogo
                let novoJogo = Jogo(
                    curso1: curso1,
                    curso2: curso2,
                    categoria: categoria,
                    genero: genero,
                    local: local,
                    data: data,
                    placar1: placar1,
                    placar2: placar2
                )
                modelContext.insert(novoJogo)
            }
        }
    }
    
    private func deletarJogo() {
        if let jogo = jogoParaEditar {
            modelContext.delete(jogo)
        } else if let natacao = jogoNatacaoParaEditar {
            modelContext.delete(natacao)
        }
    }
}

#Preview("Jogo Normal") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Jogo.self, JogoNatacao.self, configurations: config)
    
    return JogoEditingView(jogo: Jogo(
        curso1: .informatica,
        curso2: .edificacoes,
        categoria: .volei,
        genero: .mulher,
        local: "Ginásio",
        data: Date(),
        placar1: "2",
        placar2: "1"
    ))
    .modelContainer(container)
}

#Preview("Natação") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Jogo.self, JogoNatacao.self, configurations: config)
    
    return JogoEditingView(jogoNatacao: JogoNatacao(
        categoria: .natacao,
        estiloDeNado: .costa,
        genero: .homem,
        local: "Piscina",
        data: Date(),
        quantidadePessoas: "4",
        distancia: "100",
        tempo: "1min30s"
    ))
    .modelContainer(container)
}
