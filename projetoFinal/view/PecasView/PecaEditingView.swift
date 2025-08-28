//
//  PecaEditingView.swift
//  projetoFinal
//
//  Created by Found on 17/07/25.
//

import SwiftUI
import SwiftData
import PhotosUI
struct PecaEditingView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Bindable var peca: Peca
    @State private var photoItem: PhotosPickerItem?
    @State private var photoItemBackground: PhotosPickerItem?
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
                
                Section("Links externos"){
                    TextField("Link da peça no youtube", text: $peca.linkYoutube)
                    TextField("Link para o Google Photos", text: $peca.linkPhotos)
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
                    
                    if let data = peca.imagemBack, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    PhotosPicker(selection: $photoItemBackground, matching: .images) {
                        Label("Selecionar novo plano de fundo", systemImage: "photo")
                    }
                    .onChange(of: photoItemBackground) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                peca.imagemBack = data
                            }
                        }
                    }
                }
                Section {
                    Button("Cancelar"
                           , role: .cancel) {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Editar Peça")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Excluir peça", role: .destructive) {
                        context.delete(peca)
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
            
        }
    }
}
#Preview {
    let pecaExemplo = Peca(titulo: "Exemplo", sinopse: "", direcao: "", data: .now, hora: .now, local: "", curso: .informatica, periodo: .p1, linkYoutube: "", linkPhotos: "")
    PecaEditingView(peca: pecaExemplo)
}
