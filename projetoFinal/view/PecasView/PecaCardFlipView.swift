

import SwiftUI
import SwiftData

struct PecaCardFlipView: View {
    let peca: Peca
    @State private var mostrarDetalhes = false
    @State private var flipped = false

    var body: some View {
        NavigationStack {
            ZStack {
                if flipped {
                    back
                } else {
                    front
                }
            }
            .frame(width: 190, height: 280)
            .background(
                Group {
                    if let data = peca.imagem, let img = UIImage(data: data) {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 184, height: 379)
                            .clipped()
                    } else {
                        Color.gray.opacity(0.2)
                    }
                }
            )
            .cornerRadius(16)
            .rotation3DEffect(
                .degrees(flipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.easeInOut, value: flipped)
            .onTapGesture {
                flipped.toggle()
            }

            NavigationLink("", isActive: $mostrarDetalhes) {
                PecaDetailView(peca: peca)
            }
            .hidden()
        }
    }

    var front: some View {
        VStack {
            Spacer()
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(colors: [.gray.opacity(0.7), .clear], startPoint: .bottom, endPoint: .top)
            )
        }
    }

    var back: some View {
        VStack(spacing: 12) {
            Text("Direção: \(peca.direcao)")
            Text("Local: \(peca.local)")

            Button("Saiba mais") {
                mostrarDetalhes = true
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.white)
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
            .cornerRadius(20)

            Link("Fotos", destination: URL(string: "https://sec2025.blogspot.com/2025/02/21-de-fevereiro.html?m=1")!)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.white)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
                .cornerRadius(20)
        }
        .padding()
        .frame(width: 184, height: 379)
        .background(Color.white)
        .cornerRadius(16)
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
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
