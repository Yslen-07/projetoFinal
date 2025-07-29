import SwiftUI

struct PecaCardFlipView: View {
    let peca: Peca
    @State private var flipped = false

    var body: some View {
        ZStack {
            frontView
                .opacity(flipped ? 0 : 1)
            backView
                .opacity(flipped ? 1 : 0)
        }
        .frame(width: 250, height: 380)
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.4), value: flipped)
        .onTapGesture {
            flipped.toggle()
        }
    }

    var frontView: some View {
        ZStack {
            if let data = peca.imagem,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 380)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 250, height: 380)
            }

            VStack {
                Spacer()
                Text(peca.titulo)
                    .font(.title2.bold())
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
            }
            .padding()
        }
        .cornerRadius(20)
        .shadow(radius: 8)
    }

    var backView: some View {
        ZStack {
            if let data = peca.imagemBack,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 380)
                    .clipped()
            } else {
                Color.white
            }

            VStack(spacing: 16) {
                Text("Direção: \(peca.direcao)")
                    .foregroundColor(.gray)
                Text("Data: \(peca.data.formatted(date: .abbreviated, time: .omitted))")
                    .foregroundColor(.gray)
                Text("Hora: \(peca.hora.formatted(date: .omitted, time: .shortened))")
                    .foregroundColor(.gray)
                Text("Local: \(peca.local)")
                    .foregroundColor(.gray)

                Spacer()

                NavigationLink(destination: PecaDetailView(peca: peca)) {
                    Text("Saiba Mais")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .cornerRadius(20)
        .shadow(radius: 8)
    }

}

    


#Preview {
    let exemplo = Peca(

        titulo: "Alguma coisa",
        sinopse: "Uma peça sobre algo muito interessante.",
        direcao: "Eu",
        data: Date(),
        hora: Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!,
        local: "Teatro Principal",
        curso: .informatica,
        periodo: .p1,
        linkYoutube: "",
        linkPhotos: "https://pt.pngtree.com/free-backgrounds-photos/imagens-bonitas-para-fundos-pictures"
    )
    
    PecaCardFlipView(peca: exemplo)
}
