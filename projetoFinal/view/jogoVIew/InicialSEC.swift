import SwiftUI
<<<<<<< HEAD
=======
import SwiftData
>>>>>>> main

struct Categoria: Identifiable {
    let id = UUID()
    let nome: String
    let imagemNome: String
<<<<<<< HEAD
//    let cor: Color
=======
>>>>>>> main
}

struct CategoriasView: View {
    let categorias: [Categoria] = [
<<<<<<< HEAD
        Categoria(nome: "Basquete", imagemNome: "Basquete"),
        Categoria(nome: "Futsal", imagemNome: "Futsal"),
        Categoria(nome: "Vôlei", imagemNome: "Volei"),
        Categoria(nome: "Natação", imagemNome: "Natacao"),
        Categoria(nome: "Handebol", imagemNome: "Handebol"),
        Categoria(nome: "Carimba", imagemNome: "Carimba")
    ]

    var body: some View {
        NavigationView {
=======
        Categoria(nome: "Basquete", imagemNome: "basquete2"),
        Categoria(nome: "Futsal", imagemNome: "Futsal"),
        Categoria(nome: "Vôlei", imagemNome: "Volei"),
        Categoria(nome: "Natação", imagemNome: "Natacao"),
        Categoria(nome: "Handebol", imagemNome: "Squared"),
        Categoria(nome: "Carimba", imagemNome: "carimba2")
    ]

    var body: some View {
        NavigationStack {
>>>>>>> main
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
<<<<<<< HEAD
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
=======
        NavigationLink(destination: FiltroCategoria(categoriaSelecionada: categoria.nome)) {
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
                            .padding(.leading, 16)
                            .padding(.top, 8)
                        Spacer()
                    }
                }
                .frame(height: alturaTotal * 0.4)
            }
            .frame(maxWidth: 320)
            .frame(height: alturaTotal)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
>>>>>>> main
