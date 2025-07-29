import SwiftUI
import SwiftData

struct PecaDetailView: View {
    let peca: Peca
    @Environment(\.openURL) var openURL
    @Environment(\.dismiss) private var dismiss
    
    @State private var userRating: Int = 0
    @State private var isShowingRatingSheet = false
    @State private var votes = [3, 5, 8, 6, 4]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                if let data = peca.imagemBack, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .shadow(color: .white, radius: 2, x: -2, y: -2)
                        .background(
                            LinearGradient(
                                colors: [.gray.opacity(0.5), .clear],
                                startPoint: .bottom,
                                endPoint: .center
                            )
                        )
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 250)
                        .background(
                            LinearGradient(
                                colors: [.gray.opacity(0.5), .clear],
                                startPoint: .bottom,
                                endPoint: .center
                            )
                        )
                }
                Button {
                    dismiss()
                } label: {
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
              
                    Text(peca.titulo)
                        .font(.title)
                        .bold()
                    
                
                    Text("DIRIGIDO POR \(peca.direcao.uppercased())")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
             
                    HStack(alignment: .top, spacing: 20) {
                        ScrollView(.vertical) {
                            Text(peca.sinopse)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color.gray.opacity(0.7))
                                .frame(maxWidth: 200, alignment: .leading)
                        }
                        .frame(height: 200)
                        
                        if let posterData = peca.imagem, let posterImage = UIImage(data: posterData) {
                            Image(uiImage: posterImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 137, height: 221)
                                .clipped()
                                .cornerRadius(8)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 137, height: 221)
                                .overlay(Text("Cartaz").font(.caption))
                        }
                    }
                    
                    // Gráfico de notas
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notas")
                            .font(.headline)
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            ForEach(0..<5, id: \.self) { index in
                                let maxHeight: CGFloat = 100
                                let maxVotes = votes.max() ?? 1
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
                        
                        // Estrelas para avaliação
                        HStack(spacing: 4) {
                            ForEach(1...5, id: \.self) { starIndex in
                                Image(systemName: starIndex <= userRating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                            }
                        }
                    }
                    
                    // Botão para avaliar e compartilhar
                    Button {
                        isShowingRatingSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Dê sua nota e compartilhe")
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.gray.opacity(0.75))
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    .padding(.top, 16)
                    .sheet(isPresented: $isShowingRatingSheet) {
                        ratingSheet
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    var ratingSheet: some View {
        VStack(spacing: 24) {
            Text(peca.titulo)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(peca.periodo.rawValue) // use rawValue direto
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            RatingView(rating: $userRating)
            
            Button("Enviar Nota") {
                if userRating > 0 && userRating <= 5 {
                    votes[userRating - 1] += 1
                }
                isShowingRatingSheet = false
            }
            .buttonStyle(.borderedProminent)
            
            Divider()
            
            Button {
                if let url = URL(string: peca.linkYoutube), UIApplication.shared.canOpenURL(url) {
                    openURL(url)
                }
            } label: {
                Label("Assistir", systemImage: "play.fill")
            }
            
            Divider()
            
            Button {
                // Ação para compartilhar (você pode implementar)
            } label: {
                Label("Compartilhe nos Stories", systemImage: "instagram")
            }
            
            Spacer()
        }
        .padding()
        .presentationDetents([.fraction(0.40)])
        .presentationDragIndicator(.visible)
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
