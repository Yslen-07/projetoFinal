//
//  CarouselView.swift
//  projetoFinal
//
//  Created by Found on 18/07/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct CarouselView: View {
    @Query var pecas: [Peca]
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(pecas) { peca in
                        NavigationLink(destination: PecaDetailView(peca: peca)) {
                            PecaCardView(peca: peca)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Peças")
        }
    }
}
#Preview {
    CarouselView()
}

