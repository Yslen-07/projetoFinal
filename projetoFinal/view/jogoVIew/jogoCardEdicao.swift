import SwiftUI
import SwiftData

struct JogoCardEdicao: View {
    @Query(sort: \Jogo.data, order: .reverse) var jogos: [Jogo]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarConfirmacaoDeletar = false
    @State private var mostrarEdicao = false

    var jogo: Jogo
    var onEditar: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(jogo.curso1.rawValue.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.leading, 8)
                    .cornerRadius(15, corners: [.topLeft, .topRight])

                Spacer()

                Image(jogo.curso2.rawValue.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 8)
                    .cornerRadius(15, corners: [.topLeft, .topRight])
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
                .padding(.horizontal)
                .padding(.bottom, 10)
            }

            HStack(spacing: 30) {
                Button("Editar") {
                    mostrarEdicao = true
                    onEditar?()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)

                Button("Excluir") {
                    mostrarConfirmacaoDeletar = true
                    dismiss()
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1)))
        .padding(.horizontal)
        .clipShape(RoundedRectangle(cornerRadius: 43.6))
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
        .sheet(isPresented: $mostrarEdicao) {
            JogoEditingView(jogo: jogo)
                .environment(\.modelContext, modelContext)
        }
        .alert("Deseja excluir este jogo?", isPresented: $mostrarConfirmacaoDeletar) {
            Button("Excluir", role: .destructive) {
                modelContext.delete(jogo)
            }
            Button("Cancelar", role: .cancel) { }
        }
    }
}
