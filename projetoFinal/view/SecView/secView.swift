import SwiftUI
import SwiftData

struct SecView: View {
    @State private var mostrandoForm = false

    var body: some View {
        NavigationStack {
            VStack {
                SecAlunoView()
                Spacer()
                Button("Adicionar Jogo") {
                    mostrandoForm = true
                }
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $mostrandoForm) {
                    SecFormView()
                }
            }
            .navigationTitle("Jogos")
        }
    }
}
#Preview{
    SecView()
}
