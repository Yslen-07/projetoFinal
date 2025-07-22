import SwiftUI
import SwiftData

struct PecaCardFlipView: View {
    let peca: Peca
    @State private var flipped = false
    @Namespace private var flipNamespace

    var body: some View {
        ZStack {
            if flipped {
                back
            } else {
                front
            }
        }
        .rotation3DEffect(
            .degrees(flipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut, value: flipped)
        .onTapGesture {
            flipped.toggle()
        }
        .frame(width: 250, height: 360)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 6)
    }

    var front: some View {
        ZStack(alignment: .bottomLeading) {
            if let data = peca.imagem, let img = UIImage(data: data) {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else {
                Color.gray.opacity(0.2)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(peca.titulo)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                Text(peca.data.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding()
            .background(
                LinearGradient(colors: [.black.opacity(0.7), .clear], startPoint: .bottom, endPoint: .top)
            )
        }
    }

    var back: some View {
        VStack {
            Text("Direção: \(peca.direcao)")
            Text("Local: \(peca.local)")
            Button("Detalhes") {
                // Ação opcional para navegação
            }
            .padding(.top, 8)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) // Corrige o texto invertido
    }
}
#Preview {
    let exemplo = Peca(
        titulo: "Romeu e Julieta",
        sinopse: "Tragédia clássica de Shakespeare.",
        direcao: "Ana Clara",
        data: .now,
        hora: .now,
        local: "Teatro UFC",
        curso: .informatica,
        periodo: .p3,
        imagem: nil
    )
     PecaCardFlipView(peca: exemplo)
}
