import SwiftUI
import SwiftData

struct JogoCardView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var mostrarConfirmacao = false
    
    var jogo: Jogo
//    let genero: Genero = .mulher
    
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
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(jogo.curso1.rawValue.uppercased()) x \(jogo.curso2.rawValue.uppercased())")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .padding(.horizontal)
                    .offset(x: -15, y: -4)
                
                Text("Modalidade: \(jogo.categoria.rawValue)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                
                Text("Gênero: \(jogo.genero.rawValue.capitalized)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Text("Data: \(jogo.data.formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("\(jogo.placar1) : \(jogo.placar2)")
                        .font(.footnote.bold())
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1)))
        .padding(.horizontal)
        .clipShape(RoundedRectangle(cornerRadius: 43.6))
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
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
        genero: .homem,
        local: "Quadra 1",
        data: Date(),
        placar1: " ",
        placar2: " "
    )

    container.mainContext.insert(jogoE)

     return JogoCardView(jogo: jogoE)
        .padding()
        .modelContainer(container)
}
