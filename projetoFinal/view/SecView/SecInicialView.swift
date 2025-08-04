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
    let container = try! ModelContainer(
        for: Jogo.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let jogoE = Jogo(
        curso1: .informatica,
        curso2: .mecanica,
        categoria: .natacao,
        genero: .homem,
        local: "Quadra 1",
        data: Date(),
        placar1: " ",
        placar2: " "
    )

    container.mainContext.insert(jogoE)
    
    return SecInicialView()
        .modelContainer(container)
}
