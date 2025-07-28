//
//  PecaView 2.swift
//  projetoFinal
//
//  Created by Found on 15/07/25.
//



import SwiftUI
import SwiftData

struct PecaView: View {
    @State private var mostrandoForm = false

    var body: some View {
        NavigationStack {
            VStack {
                CoverFlowCarouselWithFlipView()
                    .frame(height: 400)

                Spacer()
            }
            .navigationTitle("Peças")
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
                SecFormView()
            }
        }
    }
}


#Preview {
    PecaView()
        .modelContainer(for: Peca.self, inMemory: true)
}
