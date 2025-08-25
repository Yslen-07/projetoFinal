//
//  carouselEdicao.swift
//  projetoFinal
//
//  Created by Found on 30/07/25.
//

import SwiftUI
import SwiftData


struct CarouselEdicao: View {
    @Query(sort: \Peca.data) var pecas: [Peca]
    @State private var mostrandoForm: Bool = false
    var body: some View {
        NavigationStack {
            if pecas.isEmpty {
                Text("Nenhuma peça encontrada.")
                    .padding()
            } else {
                GeometryReader { geo in
                    let cardWidth: CGFloat = 250
                    let sidePadding = (geo.size.width - cardWidth) / 2
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(pecas) { peca in
                                carouselCard(for: peca, in: geo.size)
                            }
                        }
                        .padding(.horizontal, sidePadding)
                        .padding(.vertical)
                    }
                }
                .navigationTitle("Tela edição peças")
            }
        }
    }

    @ViewBuilder
    func carouselCard(for peca: Peca, in containerSize: CGSize) -> some View {
        GeometryReader { cardGeo in
            let midX = cardGeo.frame(in: .global).midX
            let center = containerSize.width / 2
            let distance = abs(center - midX)

            let scale = max(0.85, 1.1 - distance / 400)

            PecaCardEdicao(peca: peca)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.3), value: scale)
                .padding(.horizontal, 12)
        }
        .frame(width: 250, height: 580)
        .offset(x: 0 , y: 100)
    }
}

#Preview {
    CarouselEdicao()
        .modelContainer(for: Peca.self, inMemory: true)
}
