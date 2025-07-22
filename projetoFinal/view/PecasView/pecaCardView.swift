import SwiftUI

struct PecaCardView: View {
    let peca: Peca
    @State private var isFlipped = false
    @State private var mostrarEdicao = false

    var body: some View {
        ZStack {
            if isFlipped {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .shadow(radius: 5)

               VStack(alignment: .leading, spacing: 6) {
                   
                   NavigationLink(destination: PecaDetailView(peca: peca)) {
                              Text("Saiba mais")
                                  .frame(maxWidth: .infinity)
                                  .padding(8)
                                  .background(Color.blue)
                                  .foregroundColor(.white)
                                  .cornerRadius(8)
                          }
                   
//                    Text("Direção: \(peca.direcao)")
//                    Text("Local: \(peca.local)")
//                    Text("Curso: \(peca.curso.rawValue)")
//                    Text("Período: \(peca.periodo.rawValue)")
//
//                    Divider()
//
//                    Text("Sinopse")
//                        .font(.headline)
//                    Text(peca.sinopse)
//                        .font(.footnote)
//                        .lineLimit(5)
//
//                    Spacer()
//
////                    Button("Editar") {
////                        mostrarEdicao = true
////                    }
////                    .frame(maxWidth: .infinity)
////                    .padding(8)
////                    .background(Color.blue)
////                    .foregroundColor(.white)
//                    .cornerRadius(8)
               }
                .padding()
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } else {
             
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 5)

                VStack {
                    if let data = peca.imagem, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .clipped()
                            .cornerRadius(12)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .foregroundColor(.gray)
                            .opacity(0.4)
                    }

                    Text(peca.titulo)
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text(peca.data.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(peca.hora.formatted(date: .omitted, time: .shortened))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .frame(width: 220, height: 320)
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.6), value: isFlipped)
        .onTapGesture {
            isFlipped.toggle()
        }
        .sheet(isPresented: $mostrarEdicao) {
            PecaEditingView(peca: peca)
        }
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
