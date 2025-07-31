import SwiftUI
import SwiftData

struct JogoCardView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var mostrandoEditor = false
    @State private var mostrarConfirmacao = false
    
    var jogo: Jogo

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.1))
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    .frame(width: 320, height: 180)

                VStack(spacing: 10) {
                    Text("\(jogo.curso1) VS \(jogo.curso2)")
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Text(jogo.local)
                        .font(.subheadline)

                    Text(jogo.data.formatted(date: .abbreviated, time: .shortened))
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Label(jogo.categoria.rawValue, systemImage: "sportscourt")
                        .font(.footnote)
                        .padding(.top, 4)
                }
                .padding()
            }

           HStack {
               Button("Deletar") {
                   mostrarConfirmacao = true
               }
               .tint(.red)        }
        }
        .sheet(isPresented: $mostrandoEditor) {
            JogoEditingView(jogo: jogo)
        }
        .confirmationDialog("Deseja realmente deletar este jogo?", isPresented: $mostrarConfirmacao, titleVisibility: .visible) {
            Button("Deletar", role: .destructive) {
                modelContext.delete(jogo)
            }
            Button("Cancelar", role: .cancel) { }
        }
    }
}
#Preview {
    let jogoExemplo = Jogo(
        curso1: .informatica,
        curso2: .quimica,
        categoria: .volei,
        local: "Quadra Principal",
        data: Date()
    )

    return JogoCardView(jogo: jogoExemplo)
        .padding()
        .modelContainer(for: Jogo.self)
}
