//
//  PecaDetailView.swift
//  projetoFinal
//
//  Created by Found on 18/07/25.
//

import SwiftUI
import PhotosUI
struct PecaDetailView: View {
    let peca: Peca
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let data = peca.imagem, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                }
                Text(peca.titulo).font(.title)
                Text("Direção: \(peca.direcao)")
                Text("Local: \(peca.local)")
                Text("Data: \(peca.data.formatted(date: .abbreviated, time: .omitted))")
                Text("Hora: \(peca.hora.formatted(date: .omitted, time: .shortened))")
                Text("Sinopse: \(peca.sinopse)").padding(.top)
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
        .navigationTitle("Detalhes da Peça")
    }
}
#Preview {
    let pecaExemplo = Peca(titulo: "Exemplo", sinopse: "", direcao: "", data: .now, hora: .now, local: "", curso: .informatica, periodo: .p1)
    PecaDetailView(peca: pecaExemplo)
}

