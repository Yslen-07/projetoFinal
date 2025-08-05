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
                Text("\(peca.titulo)")
                    .frame(width: 250)
                    .font(.headline)
                    .foregroundColor(.white)
                    .offset(x: 35)
                
                
                Text("\(peca.data, style: .date)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .offset(x: 50)
                    
                
            }
            .offset(x:-50)
            .padding(.bottom, 10)
            .frame(width: 250, height: 90)
            .background(
                LinearGradient(colors: [.black.opacity(1), .clear], startPoint: .bottom, endPoint: .top)
                        )
            .offset(y:145)
        }
        .frame(width: 250, height: 380)
        .cornerRadius(20)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 8)
        
        
    }

    var backView: some View {
        ZStack {

            VStack(spacing: 16) {


                NavigationLink(destination: PecaDetailView(peca: peca)) {
                    Text("Saiba Mais")
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

                if let url = URL(string: peca.linkPhotos) {
                    Link("Fotos", destination: url)
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
            }
            
            .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                }
        .frame(width: 250, height: 380)
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
