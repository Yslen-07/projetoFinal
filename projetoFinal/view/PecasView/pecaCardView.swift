
import SwiftUI


struct PecaCardView: View {
    var peca: Peca

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let imagemData = peca.imagem,
               let uiImage = UIImage(data: imagemData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else {
                Color.gray.opacity(0.3)
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
            .padding(8)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                               startPoint: .bottom,
                               endPoint: .top)
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


#Preview {
    let exemplo = Peca(
        titulo: "Alguma",
        sinopse: "Sobre algo",
        direcao: "Alguém",
        data: Date(),
        hora: Date(),
        local: "Aonde",
        curso: .informatica,
        periodo: .p3,
        imagem: nil
    )

    PecaCardView(peca: exemplo)
        .padding()
        .previewLayout(.sizeThatFits)
}
