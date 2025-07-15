//
//  PecaFormView 2.swift
//  projetoFinal
//
//  Created by Found on 11/07/25.
//


import SwiftUI
import SwiftData

struct PecaFormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
<<<<<<< HEAD

=======
    
    
    
>>>>>>> 1de8bc5 (Cadastros atualizados)
    @State var titulo_peca: String = ""
    @State var sinopse: String = ""
    @State var direcao: String = ""
    @State var elenco: String = ""
    @State var data: Date = Date()
    @State var hora: Date = Date()
    @State var local: String = ""
<<<<<<< HEAD

=======
    @State private var curso: Curso = .informatica
    @State private var periodo: Periodo = .p1
    
    
>>>>>>> 1de8bc5 (Cadastros atualizados)
    var body: some View {
        NavigationStack {
            Form {
                Section("Informações Gerais") {
                    TextField("Título da peça", text: $titulo_peca)
                    TextField("Direção", text: $direcao)
                    TextField("Elenco", text: $elenco)
                    TextField("Local", text: $local)
<<<<<<< HEAD
                }

=======
                    Picker("Período", selection: $periodo){
                        ForEach(Periodo.allCases){perio in
                            Text(perio.rawValue).tag(perio)
                            
                        }
                        
                        
                        
                    }
                }
                
>>>>>>> 1de8bc5 (Cadastros atualizados)
                Section("Sinopse") {
                    TextField("Sinopse da peça", text: $sinopse, axis: .vertical)
                        .lineLimit(4...8)
                }
<<<<<<< HEAD

=======
                
>>>>>>> 1de8bc5 (Cadastros atualizados)
                Section("Data e Hora") {
                    DatePicker("Data", selection: $data, displayedComponents: .date)
                    DatePicker("Hora", selection: $hora, displayedComponents: .hourAndMinute)
                }
<<<<<<< HEAD

                Section {
                    Button("Salvar Peça") {
                        let nova = Peca(
                            titulo: titulo_peca,
                            sinopse: sinopse,
                            direcao: direcao,
                            elenco: elenco,
                            data: data,
                            hora: hora,
                            local: local
                        )
                        context.insert(nova)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Cadastrar Peça")
        }
=======
                Section("Curso") {
                    Picker("Curso", selection: $curso) {
                        ForEach(Curso.allCases) { curso in
                            Text(curso.rawValue).tag(curso)
                        }
                    }
                }
                
                //                Section("Período") {
                //                    Picker("Período", selection: $periodo) {
                //                        ForEach(Periodo.allCases) { periodo in
                //                            Text(periodo.rawValue).tag(periodo)
                //                        }
                
            }
            
            Section {
                Button("Salvar Peça") {
                    let nova = Peca(
                        titulo: titulo_peca,
                        sinopse: sinopse,
                        direcao: direcao,
                        elenco: elenco,
                        data: data,
                        hora: hora,
                        local: local,
                        curso: curso,
                        periodo: periodo
                    )
                    context.insert(nova)
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
        }
        .navigationTitle("Cadastrar Peça")
>>>>>>> 1de8bc5 (Cadastros atualizados)
    }
}

#Preview {
    PecaFormView()
}
