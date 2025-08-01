import SwiftUI
import SwiftData

struct SecView: View {
    @State private var mostrandoForm = false

    var body: some View {
        NavigationStack {
            VStack {
                SecAdmView()
                Spacer()
            }
            .navigationTitle("Jogos SEC")
            //.toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        mostrandoForm = true
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
            //}
            .sheet(isPresented: $mostrandoForm) {
                NavigationStack {
                    SecFormView()
                        .navigationTitle("Novo Jogo")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancelar") {
                                    mostrandoForm = false
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    SecView()
        .modelContainer(for: Jogo.self, inMemory: true)
}
