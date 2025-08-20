import SwiftUI

struct PecaCardFlipView: View {
    let peca: Peca
    @State private var flipped = false

    var width: CGFloat = 250
    var height: CGFloat = 380

    var body: some View {
        ZStack {
            frontView
                .opacity(flipped ? 0 : 1)
            backView
                .opacity(flipped ? 1 : 0)
        }
        .frame(width: width, height: height)
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.4), value: flipped)
        .onTapGesture { flipped.toggle() }
    }

    var frontView: some View {
        ZStack {
            if let data = peca.imagem, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: width, height: height)
            }

            VStack {
                Spacer()
                Text(peca.titulo)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: width)
                Text(peca.data, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(width: width)
            }
            .padding(.bottom, 10)
            .background(
                LinearGradient(colors: [.black.opacity(1), .clear], startPoint: .bottom, endPoint: .top)
            )
        }
        .cornerRadius(20)
        .shadow(radius: 2)
    }

    var backView: some View {
        ZStack {
            VStack(spacing: 16) {
                NavigationLink(destination: PecaDetailView(peca: peca)) {
                    Text("Saiba Mais")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }

                if let url = URL(string: peca.linkPhotos) {
                    Link("Fotos", destination: url)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }
            .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        }
        .frame(width: width, height: height)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
    }
}

#Preview {
    let exemplo = Peca(

        titulo: "Alguma coisa piriri parara puruuru perere popo",
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
