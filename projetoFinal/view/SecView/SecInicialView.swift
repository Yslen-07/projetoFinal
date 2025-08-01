//
//  SecInicialView.swift
//  projetoFinal
//
//  Created by Found on 31/07/25.
//

import SwiftUI
import SwiftData

struct SecInicialView: View {
    @Query var jogos: [Jogo]
    

    var body: some View {
        NavigationStack {
            if jogos.isEmpty {
                Text("Nenhum jogo adicionado ainda.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(jogos) { jogo in
                        JogoCardView(jogo: jogo)
                            .swipeActions(edge: .trailing) {
        
                            }
                    }
                }
            }
        }
    }
}
#Preview {
    SecInicialView()
        .modelContainer(for: Jogo.self, inMemory: true)
}
