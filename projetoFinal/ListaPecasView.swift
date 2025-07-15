import SwiftUI
import SwiftData

struct ListaPecasView: View {
    @Query(sort: \Peca.data, order: .forward) var pecas: [Peca]

    var body: some View {
        NavigationStack {
            List(pecas) { peca in
                VStack(alignment: .leading, spacing: 6) {
                    Text(peca.titulo)
                        .font(.headline)

                    Text("Direção: \(peca.direcao)")
                        .font(.subheadline)

                    Text("Elenco: \(peca.elenco)")
                        .font(.subheadline)

                    Text("Local: \(peca.local)")
                        .font(.subheadline)

                    Text("Data: \(peca.data.formatted(date: .abbreviated, time: .omitted))")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Text("Hora: \(peca.hora.formatted(date: .omitted, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Text("Sinopse: \(peca.sinopse)")
                        .font(.body)
                        .lineLimit(3)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Peças da JAC")
        }
    }
}

#Preview {
    ListaPecasView()
        .modelContainer(for: Peca.self, inMemory: true)
}
