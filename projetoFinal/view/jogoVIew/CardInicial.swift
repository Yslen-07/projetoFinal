//
//  CardInicial.swift
//  projetoFinal
//
//  Created by Found on 05/08/25.
//

import SwiftUI
import SwiftData

struct CardInicial: View {
    @Environment(\.modelContext) private var modelContext
    var jogo: Jogo

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(jogo.imagemConfronto)
                .resizable()
                .scaledToFill()
                .frame(height: 110)
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text("\(jogo.curso1.rawValue.uppercased()) x \(jogo.curso2.rawValue.uppercased())")
                    .font(.headline)

                Text("Modalidade: \(jogo.categoria.rawValue)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)



                HStack {
                    Text("Data: \(jogo.data.formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Spacer()

                    Text("\(jogo.placar1) : \(jogo.placar2)")
                        .font(.footnote.bold())
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                
                .padding(.top, 8)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1)))
        .padding(.horizontal)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
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
    
    return CardInicial(jogo: jogoE)
        .padding()
        .modelContainer(container)
}
