//
//  filtroCategorias.swift
//  projetoFinal
//
//  Created by Found on 18/08/25.
//
import SwiftUI
import SwiftData

struct FiltroCategoria: View {
    let categoriaSelecionada: String
    @Query var jogos: [Jogo]
    var jogosFiltrados: [Jogo] {
        let hoje = Calendar.current.startOfDay(for: Date())
        return jogos.filter {
            Calendar.current.isDate($0.data, inSameDayAs: hoje) &&
            $0.categoria.rawValue == categoriaSelecionada
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("  Jogos de \(categoriaSelecionada)")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)

                if jogosFiltrados.isEmpty {
                    Text("Nenhum jogo de \(categoriaSelecionada).")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(jogosFiltrados) { jogo in
                                JogoCardView(jogo: jogo)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(categoriaSelecionada)
    }
}
#Preview {
    FiltroCategoria(categoriaSelecionada: "")
        .modelContainer(for: [Jogo.self, Peca.self])
}

