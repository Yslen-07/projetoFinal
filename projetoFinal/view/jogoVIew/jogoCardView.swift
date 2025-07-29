import SwiftUI
import SwiftData

struct JogoCardView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var mostrarConfirmacao = false
    
    var jogo: Jogo
    let genero: Genero = .mulher // ou passe como parâmetro no futuro

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(jogo.curso1.rawValue.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.leading, 8)

                Spacer()

                Image(jogo.curso2.rawValue.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 8)
            }
            .frame(height: 80)
            .background(
                LinearGradient(colors: [.gray.opacity(0.1), .white], startPoint: .leading, endPoint: .trailing)
            )

            Text("\(jogo.curso1.rawValue.uppercased()) x \(jogo.curso2.rawValue.uppercased())")
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(.horizontal)

            Text("Gênero: \(genero.rawValue)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal)

            Text("Data: \(jogo.data.formatted(date: .abbreviated, time: .shortened))")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1)))
        .shadow(radius: 4)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}
#Preview {
    let container = try! ModelContainer(
        for: Jogo.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let jogoE = Jogo(
        curso1: .informatica,
        curso2: .mecanica,
        categoria: .natacao,
        local: "Quadra 1",
        data: Date()
    )

    container.mainContext.insert(jogoE)

    return JogoCardView(jogo: jogoE)
        .padding()
        .modelContainer(container)
}
