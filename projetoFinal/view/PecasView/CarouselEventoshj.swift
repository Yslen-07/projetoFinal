//
//  CarouselEventoshj.swift
//  projetoFinal
//
//  Created by found on 21/08/25.
//

import SwiftUI
import SwiftData

struct CarouselEventoshj: View {
    @Query var pecas: [Peca]

    var pecasHoje: [Peca] {
        let hoje = Calendar.current.startOfDay(for: Date())
        return pecas.filter { Calendar.current.isDate($0.data, inSameDayAs: hoje) }
    }

    var body: some View {
        NavigationStack {
            if pecasHoje.isEmpty {
                VStack{
                    Text("Contagem regressiva até o inicio da JAC")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                    CountdownTimerView(endDate: "2025-12-05T00:00:00Z")
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(pecasHoje) { peca in
                            GeometryReader { cardGeo in
                                let cardWidth: CGFloat = 250
                                let cardHeight: CGFloat = 350
                                let midX = cardGeo.frame(in: .global).midX
                                let screenCenter = UIScreen.main.bounds.width / 2
                                let distance = abs(screenCenter - midX)
                                let scale = max(0.90, 1.1 - distance / 400)

                                PecaCardFlipView(peca: peca, width: cardWidth, height: cardHeight)
                                    .scaleEffect(scale)
                                    .animation(.easeInOut(duration: 0.3), value: scale)
                            }
                            .frame(width: 250, height: 380)
                        }
                    }
                    .padding(.horizontal, 60)
                    .padding(.vertical, 20)
                }
                .navigationTitle("Eventos de hoje")
            }
        }
    }
}

#Preview {
    CarouselEventoshj()
        .modelContainer(for: Peca.self, inMemory: true)
}
