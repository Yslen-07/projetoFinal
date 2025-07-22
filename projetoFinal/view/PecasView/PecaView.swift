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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(pecas) { peca in
                        PecaCardView(peca: peca)
                            .frame(width: 240, height: 340)
                    }
                }
                .padding()
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
                PecaFormView()
            }
        }
    }
}

#Preview {
    PecaView()
        .modelContainer(for: Peca.self, inMemory: true)
}

