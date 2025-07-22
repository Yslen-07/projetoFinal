import SwiftUI

struct PecaCardView: View {
    var peca: Peca
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            if isFlipped {
                MyCard(text: "Viado péssimo amigo", color: .green)
            } else {
                VStack {
                    if let data = peca.imagem, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 250)
                            .clipped()
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 200, height: 250)
                            .overlay(Text("Sem imagem").foregroundColor(.gray))
                    }
                    Text(peca.titulo)
                        .font(.headline)
                        .frame(maxWidth: 200)
                        .lineLimit(1)
                }
                .frame(width: 200)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
        }
        .frame(width: 200, height: 300)
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.6)) {
                isFlipped.toggle()
            }
        }
    }

    struct MyCard: View {
        var text: String
        var color: Color

        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
                    .frame(width: 200, height: 300)
                    .shadow(radius: 5)
                Text(text)
                    .font(.title2)
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    let pecaExemplo = Peca(titulo: "Exemplo", sinopse: "", direcao: "", data: .now, hora: .now, local: "", curso: .informatica, periodo: .p1)
    PecaCardView(peca: pecaExemplo)
}


