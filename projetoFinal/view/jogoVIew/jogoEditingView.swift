//
//  jogoEditingView.swift
//  projetoFinal
//
//  Created by Found on 01/08/25.
//

import SwiftUI
import SwiftData

struct JogoEditingView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query(sort: \Jogo.data, order: .reverse) var jogos: [Jogo]
    
    @State var curso1: Curso = .informatica
    @State var curso2: Curso = .edificacoes
    @State var local: String = ""
    @State var data: Date = Date()
    @State var categoria: CategoriaEsportiva = .natacao
    @State var genero: Genero = .mulher
    @State var placar1: String = ""
    @State var placar2: String = ""
    
    let jogo: Jogo?
    
    init(jogo: Jogo? = nil) {
        self.jogo = jogo
    }
    
    var body: some View {
        Form {
            Section(header: Text("Editar o jogo:")) {
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
            
            Section(header: Text("Local e Data")) {
                TextField("Local", text: $local)
                DatePicker("Data do jogo", selection: $data, displayedComponents: [.date, .hourAndMinute])
            }
            
            Section(header: Text("Modalidade")) {
                Picker("Modalidade", selection: $categoria) {
                    ForEach(CategoriaEsportiva.allCases) { cat in
                        Text(cat.rawValue).tag(cat)
                    }
                }
                Picker("Gênero", selection: $genero) {
                    ForEach(Genero.allCases) { genero in
                        Text(genero.rawValue).tag(genero)
                    }
                }
                
                Section(header: Text("Placar")) {
                    TextField("Placar do Curso 1", text: $placar1)
                        .keyboardType(.numberPad)
                    TextField("Placar do Curso 2", text: $placar2)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button("Salvar alterações") {
                        if let jogo = jogo {
                            jogo.curso1 = curso1
                            jogo.curso2 = curso2
                            jogo.local = local
                            jogo.data = data
                            jogo.categoria = categoria
                            jogo.placar1 = placar1
                            jogo.placar2 = placar2
                        } else {
                            let jogo = Jogo(
                                curso1: curso1,
                                curso2: curso2,
                                categoria: categoria,
                                genero: genero,
                                local: local,
                                data: data,
                                placar1: placar1,
                                placar2: placar2
                            )
                            modelContext.insert(jogo)
                        }
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button("Deletar jogo") {
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
                    placar1 = jogo.placar1
                    placar2 = jogo.placar2
                }
            }
        }
    }
}

#Preview {
    JogoEditingView(
        jogo: Jogo(
            curso1: .informatica,
            curso2: .eletrotecnica,
            categoria: .futsal,
            genero: .mulher,
            local: "Ginásio",
            data: Date(),
            placar1: "1",
            placar2: "0"
        )
    )
    .modelContainer(for: Jogo.self)
}
