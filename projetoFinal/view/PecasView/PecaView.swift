//
//  PecaView 2.swift
//  projetoFinal
//
//  Created by Found on 15/07/25.
//


import SwiftUI
import SwiftData

struct PecaView: View {
    @Query var pecas: [Peca]
    @State private var mostrandoForm = false

    var body: some View {
        NavigationStack {
            VStack {
                ForEach(pecas) { peca in
                    PecaCardView(peca: Peca(
                        titulo: peca.titulo,
                        sinopse: peca.sinopse,
                        direcao: peca.direcao,
                        data: Date(),
                        hora: Date(),
                        local: peca.local,
                        curso: peca.curso,
                        periodo: peca.periodo,
                        imagem: nil
                    ))
                }
                
            }
            

                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            mostrandoForm = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $mostrandoForm) {
                    PecaFormView()
                }
                
        }
        .onAppear {
            print(pecas.count)
        }
    }
}

#Preview {
    PecaView()
}
