import SwiftUI

struct PecaDetailView: View {
    let peca: Peca
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    
    @State private var userRating: Int = 0
    @State private var isShowing = false
    
    // Votos acumulados para cada nota (1 a 5)
    @State private var votes = [3, 5, 8, 6, 4] // exemplo inicial, você pode zerar ou carregar do backend
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack(alignment: .topLeading) {
                if let data = peca.imagemBack, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .shadow(color: Color.white, radius: 2, x: -2, y: -2)
                        .background(LinearGradient(colors: [.gray.opacity(0.5), .clear], startPoint:.bottom,endPoint: .center))
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 250)
                        .background(LinearGradient(colors: [.gray.opacity(0.5), .clear], startPoint:.bottom,endPoint: .center))
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                        .padding(.top, 50)
                        .padding(.leading, 16)
                }
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Título
                    Text(peca.titulo)
                        .font(.title)
                        .bold()
                    
                    // Direção
                    Text("DIRIGIDO POR  \(peca.direcao.uppercased())")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Sinopse + Cartaz
                    ScrollView(.vertical){
                        VStack(spacing: 20) {
                            Text(peca.sinopse)
                                .font(
                                    Font.custom("SF Pro", size: 12)
                                        .weight(.medium))
                                .kerning(0.3)
                                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                        }
                    }
                    .frame(width: 200, height: 200, alignment: .leading)
                    
                    HStack{
                        if let posterData = peca.imagem, let posterImage = UIImage(data: posterData) {
                            Image(uiImage: posterImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 137, height: 221)
                                .clipped()
                                .cornerRadius(8)
                                .offset(x:230, y:0)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 137, height: 221)
                                .overlay(Text("Cartaz").font(.caption))
                                .offset(x:230, y:0)
                        }
                    }
                    .offset(x:0, y:-235)
                    
                    // Gráfico reativo de notas (substitui sua seção Notas original)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notas")
                            .font(.headline)
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            ForEach(0..<5) { index in
                                let maxHeight: CGFloat = 100
                                let maxVotes = (votes.max() ?? 1)
                                let height = maxVotes > 0 ? CGFloat(votes[index]) / CGFloat(maxVotes) * maxHeight : 0
                                
                                VStack {
                                    Rectangle()
                                        .fill(index == userRating - 1 ? Color.blue : Color.gray.opacity(0.6))
                                        .frame(width: 20, height: height)
                                        .cornerRadius(4)
                                        .animation(.easeInOut, value: votes)
                                    
                                    Text("\(index + 1)")
                                        .font(.caption)
                                }
                            }
                        }
                        .offset(x: 90, y: -8)
                        
                        HStack(spacing: 4) {
                            HStack(spacing: 4) {
                                ForEach(0..<5) { starIndex in
                                    Image(systemName: starIndex < userRating ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                }
                            }
                        }
                        .offset(x: 120, y: -8)
                    }
                    .offset(x:0, y:-210)
                    .padding(.horizontal)
                    
                    VStack {
                        Button {
                            isShowing.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Dê sua nota e compartilhe")
                            }
                            .frame(width: 370, height: 40)
                            .background(Color(red: 0.75, green: 0.74, blue: 0.74))
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        }
                    }
                    .offset(x: 0, y: -200)
                    .sheet(isPresented: $isShowing) {
                        VStack(spacing: 24) {
                            Text("\(peca.titulo)")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            Text("\(peca.periodo)")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                            
                            RatingView(rating: $userRating)
                            
                            Button("Enviar Nota") {
                                if userRating > 0 && userRating <= 5 {
                                    votes[userRating - 1] += 1
                                }
                                isShowing = false
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Divider()
                            
                            Button {
                                if let url = URL(string: peca.linkYoutube) {
                                    openURL(url)
                                } else {
                                    print("URL inválida")
                                }
                            } label: {
                                Label("Assistir", systemImage: "play.fill")
                            }
                            
                            Divider()
                            
                            Button {
                                // Ação para "Compartilhe nos Stories"
                            } label: {
                                Label("Compartilhe nos Stories", systemImage: "instagram")
                            }
                            Spacer()
                        }
                        .padding()
                        .presentationDetents([.fraction(0.40)])
                        .presentationDragIndicator(.visible)
                    }
                    .offset(x: 0, y: 0)
                    
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
    }
}

struct RatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.yellow)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        rating = index
                    }
            }
        }
        .padding(.horizontal, 16)
    }
}
#Preview {
    let pecaExemplo = Peca(titulo: "Unidos", sinopse: "Unidos! é uma história emocionante que explora o amor, a dualidade e, acima de tudo, a união. Nos anos 60, em meio ao ápice das tensões da Guerra Fria, Dyna, uma brilhante estudante de matemática,determinada a cumprir seus objetivos a todo custo. Durante seus anos de faculdade, ela conhece Neil, um jovem radical e de espírito livre. Conforme o tempo passa, tanto o seu relacionamento quanto sua carreira decolaram, e a vida de Dyna parece finalmente perfeita. Mas, quando um segredo sombrio ameaça tudo o que ela construiu, sua lealdade, seus sentimentos e seu futuro serão postos à prova. Será que Dyna e Neil permanecerão unidos até o fim?", direcao: "", data: .now, hora: .now, local: "", curso: .informatica, periodo: .p3, linkYoutube: "", linkPhotos: "")
    PecaDetailView(peca: pecaExemplo)
}

