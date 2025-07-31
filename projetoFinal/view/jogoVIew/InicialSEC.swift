import SwiftUI

struct Categoria: Identifiable {
    let id = UUID()
    let nome: String
    let imagemNome: String
//    let cor: Color
}

struct CategoriasView: View {
    let categorias: [Categoria] = [
        Categoria(nome: "Basquete", imagemNome: "Basquete"),
        Categoria(nome: "Futsal", imagemNome: "Futsal"),
        Categoria(nome: "Vôlei", imagemNome: "Volei"),
        Categoria(nome: "Natação", imagemNome: "Natacao"),
        Categoria(nome: "Handebol", imagemNome: "Handebol"),
        Categoria(nome: "Carimba", imagemNome: "Carimba")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(categorias) { categoria in
                        CategoriaCardView(categoria: categoria)
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("SEC")
        }
    }
}

struct CategoriaCardView: View {
    let categoria: Categoria
    let alturaTotal: CGFloat = 200

    var body: some View {
        VStack(spacing: 0) {
            Image(categoria.imagemNome)
                .resizable()
                .scaledToFill()
                .frame(height: alturaTotal * 0.6)
                .clipped()

            ZStack {
                Color.white
                VStack(alignment: .leading) {
                    Text(categoria.nome)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading, -140)
                        .padding(.top, 8)
                    Spacer()
                }
            }
            .frame(height: alturaTotal * 0.4)
        }
        .frame(maxWidth: 320) // ← aqui definimos a largura máxima do card
        .frame(height: alturaTotal)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 4)
        .onTapGesture {
            print("Selecionou: \(categoria.nome)")
        }
    }
}

#Preview {
    CategoriasView()
}
