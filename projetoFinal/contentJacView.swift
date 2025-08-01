//
//  contentJacView.swift
//  projetoFinal
//
//  Created by Found on 30/07/25.
//

//
//  PecaView 2.swift
//  projetoFinal
//
//  Created by Found on 15/07/25.
//



import SwiftUI
import SwiftData

struct ContentJacView: View {
    @State private var mostrandoForm = false

    var body: some View {
        NavigationStack {
            VStack {
                CarouselEdicao()
                    .frame(height: 400)

                Spacer()
            }
            .navigationTitle("Tela de edição de JAC")
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
    ContentJacView()
        .modelContainer(for: Peca.self, inMemory: true)
}
