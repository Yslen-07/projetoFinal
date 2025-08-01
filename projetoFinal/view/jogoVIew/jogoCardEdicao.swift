import SwiftUI
import SwiftData

struct JogoCardEdicao: View {
    @Environment(\.modelContext) private var modelContext
    @State private var mostrarEdicao = false
    @State private var mostrarConfirmacaoDeletar = false
    
    @State private var placar1: String = ""
    @State private var placar2: String = ""
    var jogo: Jogo
    let genero: Genero = .mulher

    var body: some View {
        ZStack(alignment: .topTrailing) {
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
                    
                    
                }
                    
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
                        
                        
                    Button {
                            mostrarConfirmacaoDeletar = true
                            } label: {
                                Image(systemName: "trash")
                                .foregroundColor(.white)
            //                    .padding(8)
                                .background(Color.red)
                                .clipShape(Circle())
                                .shadow(radius: 2)
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
       
        .sheet(isPresented: $mostrarEdicao) {
            JogoEditingView(jogo: jogo)
        }
    }
}
