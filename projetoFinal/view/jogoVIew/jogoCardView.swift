import SwiftUI
import SwiftData

// MARK: - Extensão para arredondar cantos específicos
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - Card de Jogos
struct JogoCardView: View {
    @Environment(\.modelContext) private var modelContext
    var jogo: Jogo
    
    var body: some View {
        VStack {
            if jogo.categoria == .natacao {
                // Card para Natação
                VStack(alignment: .leading, spacing: 8) {
                    Image(jogo.imagemConfronto) // ex: "cardNatacao2"
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipped()
                        .cornerRadius(15, corners: [.topLeft, .topRight]) 
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Modalidade: Natação")
                            .font(.headline)
                        
                        Text("Local: \(jogo.local)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Data: \(jogo.data.formatted(date: .abbreviated, time: .shortened))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
                .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1)))
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
                
            } else {
                
                VStack(alignment: .leading, spacing: 12) {
                    Image(jogo.imagemConfronto)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 110)
                        .clipped()
                        .cornerRadius(15, corners: [.topLeft, .topRight]) 
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(jogo.curso1.rawValue.uppercased()) x \(jogo.curso2.rawValue.uppercased())")
                            .font(.headline)
                        
                        Text("Modalidade: \(jogo.categoria.rawValue)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Gênero: \(jogo.genero.rawValue.capitalized)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text("Data: \(jogo.data.formatted(date: .abbreviated, time: .shortened))")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            if jogo.categoria != .natacao {
                                Text("\(jogo.placar1) : \(jogo.placar2)")
                                    .font(.footnote.bold())
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 10)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding(.top, 8)
                        
                        Text("Local: \(jogo.local)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
                .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1)))
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
            }
        }
    }
}

struct JogoCardView_Previews: PreviewProvider {
    static let jogoE = Jogo(
        curso1: .informatica,
        curso2: .mecanica,
        categoria: .futsal,
        genero: .homem,
        local: "Quadra 1",
        data: Date(),
        placar1: "2",
        placar2: "1"
    )
    
    static let jogoNatacao = Jogo(
        curso1: .edificacoes,
        curso2: .eletrotecnica,
        categoria: .natacao,
        genero: .mulher,
        local: "Piscina Olímpica",
        data: Date(),
        placar1: "-",
        placar2: "-"
    )
    
    static var previews: some View {
        ScrollView {
            VStack(spacing: 16) {
                JogoCardView(jogo: jogoE)
                JogoCardView(jogo: jogoNatacao)
            }
            .padding()
        }
    }
}
