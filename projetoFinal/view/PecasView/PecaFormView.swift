//
//  PecaFormView.swift
//  projetoFinal
//
//  Created by Found on 11/07/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct PecaFormView: View {
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
    @State private var imagemBack: Data?
    @State private var linkYoutube: String = ""
    @State private var linkPhotos: String = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photoItemBackground: PhotosPickerItem?

    var body: some View {
        NavigationStack {
            Form {
                Section("Informações Gerais") {
                    TextField("Título da peça", text: $titulo_peca)
                    TextField("Direção", text: $direcao)
                    TextField("Local", text: $local)

                    Picker("Período", selection: $periodo) {
                        ForEach(Periodo.allCases) { perio in
                            Text(perio.rawValue).tag(perio)
                        }
                    }
                }
                
                Section("Links externos") {
                    TextField("Link da peça no YouTube", text: $linkYoutube)
                    TextField("Link para o Google Photos", text: $linkPhotos)
                }

                Section("Imagem") {
                    if let imagem, let uiImage = UIImage(data: imagem) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        Label("Selecionar pôster", systemImage: "photo")
                    }
                    .onChange(of: photoItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                imagem = data
                            }
                        }
                    }
                    
                    if let imagemBack, let uiImage = UIImage(data: imagemBack) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    PhotosPicker(selection: $photoItemBackground, matching: .images) {
                        Label("Selecionar plano de fundo", systemImage: "photo")
                    }
                    .onChange(of: photoItemBackground) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                imagemBack = data
                            }
                        }
                    }
                }

                Section("Data e Hora") {
                    DatePicker("Data", selection: $data, displayedComponents: .date)
                    DatePicker("Hora", selection: $hora, displayedComponents: .hourAndMinute)
                }

                Section("Sinopse") {
                    TextField("Sinopse da peça", text: $sinopse, axis: .vertical)
                        .lineLimit(4...8)
                }

                Section("Curso") {
                    Picker("Curso", selection: $curso) {
                        ForEach(Curso.allCases) { curso in
                            Text(curso.rawValue).tag(curso)
                        }
                    }
                }
                
                Section {
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
                            imagem: imagem,
                            imagemBack: imagemBack,
                            linkYoutube: linkYoutube,
                            linkPhotos: linkPhotos
                        )
                        context.insert(nova)
                        // dismiss()  ← você pode ativar se quiser fechar após salvar
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
    }
}

#Preview {
    PecaFormView()
        .modelContainer(for: Peca.self, inMemory: true)
}
