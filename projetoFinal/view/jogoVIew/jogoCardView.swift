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

// MARK: - Card para Jogos Normais
struct JogoCardView: View {
    @Environment(\.modelContext) private var modelContext
    var jogo: Jogo
    
    var body: some View {
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
                    
                    Text("\(jogo.placar1) : \(jogo.placar2)")
                        .font(.footnote.bold())
                        .padding(.vertical, 1)
                        .padding(.horizontal, 10)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
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

// MARK: - Card específico para Natação
struct NatacaoCardView: View {
    @Environment(\.modelContext) private var modelContext
    var jogoNatacao: JogoNatacao
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(jogoNatacao.imagemConfronto)
                .resizable()
                .scaledToFill()
                .frame(height: 110)
                .clipped()
                .cornerRadius(15, corners: [.topLeft, .topRight])
                
            VStack(alignment: .leading, spacing: 4) {
                Text("Modalidade: Natação")
                    .font(.headline)
                
                Text("Estilo: \(jogoNatacao.estiloDeNado.rawValue)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Local: \(jogoNatacao.local)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Data: \(jogoNatacao.data.formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Text("Gênero: \(jogoNatacao.genero.rawValue.capitalized)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Text("Participantes: \(jogoNatacao.quantidadePessoas)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Text("Distância: \(jogoNatacao.distancia)m")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Text("Tempo: \(jogoNatacao.tempo)")
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

// MARK: - View Universal que decide qual card mostrar
struct UniversalCardView: View {
    var item: Any
    
    var body: some View {
        if let jogo = item as? Jogo {
            JogoCardView(jogo: jogo)
        } else if let jogoNatacao = item as? JogoNatacao {
            NatacaoCardView(jogoNatacao: jogoNatacao)
        } else {
            Text("Tipo não suportado")
                .foregroundColor(.red)
        }
    }
}

// MARK: - Previews
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
    
    static let jogoNatacao = JogoNatacao(
        categoria: .natacao,
        estiloDeNado: .costa,
        genero: .mulher,
        local: "Piscina Olímpica",
        data: Date(),
        quantidadePessoas: "8",
        distancia: "100",
        tempo: "1:30"
    )
    
    static var previews: some View {
        ScrollView {
            VStack(spacing: 16) {
                JogoCardView(jogo: jogoE)
                NatacaoCardView(jogoNatacao: jogoNatacao)
                
                UniversalCardView(item: jogoE)
                UniversalCardView(item: jogoNatacao)
            }
            .padding()
        }
    }
}
