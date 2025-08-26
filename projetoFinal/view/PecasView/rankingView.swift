import SwiftUI
import SwiftData

struct RankingPecasView: View {
    @Query private var pecas: [Peca]

    var pecasOrdenadas: [Peca] {
        pecas.sorted {
            let n1 = $0.numeroAvaliacoes > 0 ? Double($0.totalEstrelas)/Double($0.numeroAvaliacoes) : 0
            let n2 = $1.numeroAvaliacoes > 0 ? Double($1.totalEstrelas)/Double($1.numeroAvaliacoes) : 0
            return n1 > n2
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(pecasOrdenadas.enumerated()), id: \.element.id) { index, peca in
                    HStack(alignment: .top, spacing: 12) {
                        // Posição no ranking
                        Text("\(index + 1)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .frame(width: 30)

                        // Poster
                        if let data = peca.imagem, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 100)
                                .cornerRadius(8)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 70, height: 100)
                                .cornerRadius(8)
                                .overlay(Text("Sem imagem").font(.caption2))
                        }

                        // Infos
                        VStack(alignment: .leading, spacing: 6) {
                            Text(peca.titulo)
                                .font(.headline)

                            HStack {
                                Text("\(Calendar.current.component(.year, from: peca.data))")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)

                                Text(peca.curso.rawValue)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }

                            HStack {
                                let nota = peca.numeroAvaliacoes > 0 ? Double(peca.totalEstrelas)/Double(peca.numeroAvaliacoes) : 0
                                Text(String(format: "%.1f", nota))
                                    .bold()
                                StarsRatingView(rating: nota)
                                Text("(\(peca.numeroAvaliacoes))")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Ranking das peças")
        }
    }
}

struct StarsRatingView: View {
    var rating: Double
    private let maxRating = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { i in
                Image(systemName: i <= Int(rating.rounded()) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    RankingPecasView()
        .modelContainer(for: Peca.self, inMemory: true)
}
