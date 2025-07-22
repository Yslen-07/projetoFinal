//
//  PecaEditingView.swift
//  projetoFinal
//
//  Created by Found on 17/07/25.
//

////
////  PecaEditingView.swift
////  projetoFinal
////
////  Created by Found on 17/07/25.
////
//
import SwiftUI
import SwiftData
import PhotosUI
struct PecaEditingView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State var titulo_peca: String = ""
    @State var sinopse: String = ""
    @State var direcao: String = ""
    @State var data: Date = Date()
    @State var hora: Date = Date()
    @State var local: String = ""
    @State private var curso: Curso = .informatica
    @State private var periodo: Periodo = .p1
    @State private var imagem: Data?
    
    @Bindable var peca: Peca
    @State private var photoItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Informações Gerais") {
                    TextField("Título"
                              , text: $peca.titulo)
                    TextField("Direção"
                              , text: $peca.direcao)
                    TextField("Local"
                              , text: $peca.local)
                    Picker("Período"
                           , selection: $peca.periodo) {
                        ForEach(Periodo.allCases) { Text($0.rawValue).tag($0) }
                    }
                }
                Section("Sinopse") {
                    TextField("Sinopse"
                              , text: $peca.sinopse, axis: .vertical)
                    .lineLimit(4...8)
                }
                Section("Data e Hora") {
                    DatePicker("Data", selection: $peca.data, displayedComponents: .date)
                    DatePicker("Hora", selection: $peca.hora, displayedComponents:
                            .hourAndMinute)
                }
                Section("Curso") {
                    Picker("Curso", selection: $peca.curso) {
                        ForEach(Curso.allCases) { Text($0.rawValue).tag($0) }
                    }
                }
                Section("Imagem") {
                    if let data = peca.imagem, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        Label("Selecionar nova imagem", systemImage: "photo")
                    }
                    .onChange(of: photoItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                peca.imagem = data
                            }
                        }
                    }
                }
                Section {
                    Button("Cancelar"
                           , role: .cancel) {
                        dismiss()
                    }
                    
                    Button("Deletar peça" ,
                           role: .destructive) {
                        dismiss()
                    }
                    
                    
                    Button("Salvar Peça") {
                        let nova = Peca(
                            titulo: titulo_peca,
                            sinopse: sinopse,
                            direcao: direcao,
                            data: data,
                            hora: hora,
                            local: local,
                            curso: curso,
                            periodo: periodo,
                            imagem: imagem
                        )
                        context.insert(nova)
                        dismiss()
                    }
                }
                }
        }
            .navigationTitle("Editar Peça")
        }
}

#Preview {
    let pecaExemplo = Peca(titulo: "", sinopse: "", direcao: "", data: .now, hora: .now, local: "", curso: .informatica, periodo: .p1)
    PecaEditingView(peca: pecaExemplo)
}

