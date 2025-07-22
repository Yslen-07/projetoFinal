//
//  PecaView 2.swift
//  projetoFinal
//
//  Created by Found on 15/07/25.
//


import SwiftUI

struct PecaView: View {
    @State private var mostrandoForm = false

    var body: some View {
        NavigationStack {
            ListaPecasView()
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
}
