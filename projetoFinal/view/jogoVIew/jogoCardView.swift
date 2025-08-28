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

struct JogoCardView: View {
    @Environment(\.modelContext) private var modelContext
    
    var jogo: Jogo?
    var jogoNatacao: JogoNatacao?
    
    var isAdmin: Bool = false
    var onEdit: (() -> Void)? = nil
    
    // Altura padrão da imagem
    private let imageHeight: CGFloat = 110
    
    var body: some View {
        VStack(spacing: 0) {
            // Imagem de topo
            Group {
                if let jogo = jogo {
                    Image(jogo.imagemConfronto)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(jogoNatacao!.imagemConfronto)
                        .resizable()
                        .scaledToFill()
                        .frame(height: imageHeight)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(15, corners: [.topLeft, .topRight])

                }
            }
            .frame(height: imageHeight)
            .frame(maxWidth: .infinity)
            .clipped()
            .cornerRadius(15, corners: [.topLeft, .topRight])
            
            // Conteúdo do card
            VStack(alignment: .leading, spacing: 6) {
                if let jogoNatacao = jogoNatacao {
                    cardNatacaoContent(jogoNatacao)
                } else if let jogo = jogo {
                    cardOutrosEsportesContent(jogo)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                )
        )
        .overlay(editButton, alignment: .topTrailing)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
        .padding(.horizontal)
    }
    
    // MARK: - Card Natação
    private func cardNatacaoContent(_ jogo: JogoNatacao) -> some View {
        HStack(spacing: 20){
            Text("Modalidade: Natação")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Estilo de nado: \(jogo.estiloDeNado.rawValue)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
        
        return VStack(alignment: .leading, spacing: 6) {
            infoRow(label: "Local:", value: jogo.local)
            infoRow(label: "Data:", value: jogo.data.formatted(date: .abbreviated, time: .shortened))
            infoRow(label: "Gênero:", value: jogo.genero.rawValue.capitalized)
            infoRow(label: "Distância:", value: jogo.distancia)
        }
        
    }
    
    // MARK: - Card Outros Esportes
    private func cardOutrosEsportesContent(_ jogo: Jogo) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(jogo.curso1.rawValue.uppercased()) x \(jogo.curso2.rawValue.uppercased())")
                .font(.headline)
                .foregroundColor(.primary)
            
            infoRow(label: "Modalidade:", value: jogo.categoria.rawValue)
            infoRow(label: "Gênero:", value: jogo.genero.rawValue.capitalized)
            
            infoRow(label: "Data:", value: jogo.data.formatted(date: .abbreviated, time: .shortened))
            infoRow(label: "Local:", value: jogo.local)
            
            // Placar sempre no final
            HStack {
                Spacer()
                Text("\(jogo.placar1) : \(jogo.placar2)")
                    .font(.system(.body, design: .rounded).bold())
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
    }
    
    // MARK: - Botão Edição
    private var editButton: some View {
        Group {
            if isAdmin {
                Button(action: { onEdit?() }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(10)
            }
        }
    }
    
    // MARK: - Info Row
    private func infoRow(label: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(label)
                .font(.footnote)
                .foregroundColor(.secondary)
            Text(value)
                .font(.footnote)
                .foregroundColor(.primary)
        }
    }
}

// MARK: - Preview
struct JogoCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Preview para Jogo (outros esportes)
            JogoCardView(
                jogo: Jogo(
                    curso1: .informatica,
                    curso2: .quimica,
                    categoria: .futsal,
                    genero: .homem,
                    local: "Quadra Central", data: Date(),
                    placar1: "3",
                    placar2: "3"
                ),
                isAdmin: true
            )
            
            // Preview para JogoNatacao
            JogoCardView(
                jogoNatacao: JogoNatacao(
                    categoria: .natacao,
                    estiloDeNado: .peito,
                    genero: .mulher,
                    local: "Piscina Olímpica",
                    data: Date(),
                    quantidadePessoas: "10",
                    distancia: "100m",
                    tempo: "00:55"
                ),
                isAdmin: true
            )
        }
        .previewLayout(.sizeThatFits)
    }
}
