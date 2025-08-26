import SwiftUI
import SwiftData

struct SecNatacaoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var formSec = false
    @State private var local: String = ""
    @State private var data: Date = Date()
    @State private var categoriaSelecionada: CategoriaEsportiva = .natacao
    @State private var genero: Genero = .mulher
    @State private var estiloDeNado: EstiloDeNado = .costa
    @State private var quantidadePessoas: String = ""
    @State private var distancia: String = ""
    @State private var tempo: String = ""
    
    var body: some View {
        Form {
            Section("Modalidade") {
                Picker("Categoria", selection: $categoriaSelecionada) {
                    ForEach(CategoriaEsportiva.allCases) { cat in
                        Text(cat.rawValue).tag(cat)
                    }
                }
                .onChange(of: categoriaSelecionada) { oldValue, newValue in
                    if newValue != .natacao {
                        formSec = true
                    }
                }
                
                Picker("Estilo", selection: $estiloDeNado) {
                    ForEach(EstiloDeNado.allCases) { nado in
                        Text(nado.rawValue).tag(nado)
                    }
                }
                
                Picker("Gênero", selection: $genero) {
                    ForEach(Genero.allCases) { genero in
                        Text(genero.rawValue).tag(genero)
                    }
                }
            }
            
            Section("Participantes") {
                TextField("Número de participantes", text: $quantidadePessoas)
                    .keyboardType(.numberPad)
            }
            
            Section("Tempo e Distância") {
                TextField("Tempo (00min:00s)", text: $tempo)
                TextField("Distância (metros)", text: $distancia)
                    .keyboardType(.numberPad)
            }
            
            Section("Local e Data") {
                TextField("Local", text: $local)
                DatePicker("Data e Hora", selection: $data, displayedComponents: [.date, .hourAndMinute])
            }
            
            Section {
                Button("Salvar Jogo") {
                    let novoJogo = JogoNatacao(
                        categoria: categoriaSelecionada,
                        estiloDeNado: estiloDeNado,
                        genero: genero,
                        local: local,
                        data: data,
                        quantidadePessoas: quantidadePessoas,
                        distancia: distancia,
                        tempo: tempo
                    )
                    modelContext.insert(novoJogo)
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
        .navigationTitle("Natação")
        .navigationDestination(isPresented: $formSec) {
            SecFormView()
                .navigationTitle("Back")
        }
        
    }
}


#Preview{
    SecNatacaoView()
        .modelContainer(for: JogoNatacao.self, inMemory: true)
}
