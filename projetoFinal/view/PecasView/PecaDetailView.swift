import SwiftUI
import SwiftData

struct PecaDetailView: View {
    let peca: Peca
    @Environment(\.modelContext) private var context
    @Environment(\.openURL) var openURL
    @Environment(\.dismiss) private var dismiss
    
    @State private var userRating: Int = 0
    @State private var isShowingRatingSheet = false
    @State private var isShowingShareSheet = false

    private var jaVotou: Bool {
        let votadas = UserDefaults.standard.stringArray(forKey: "pecasVotadas") ?? []
        return votadas.contains(peca.id.uuidString)
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                if let data = peca.imagemBack, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 214)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 214)
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
                    
                    Text("DIRIGIDO POR \(peca.direcao)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    HStack(alignment: .top, spacing: 20) {
                        ScrollView(.vertical) {
                            Text(peca.sinopse)
                                .font(.system(size: 14))
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
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Média de Notas")
                            .font(.headline)
                        
                        HStack {
                            Text(String(format: "%.1f", peca.nota))
                                .bold()
                            StarsRatingView(rating: peca.nota)
                            Text("(\(peca.numeroAvaliacoes))")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                    Spacer()
                    Spacer()
                    // Botão de avaliar
                    Button {
                        isShowingRatingSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "star.fill")
                            Text(jaVotou ? "Você já votou" : "Avaliar peça")
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(jaVotou ? Color.gray.opacity(0.5) : Color.blue.opacity(0.75))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .disabled(jaVotou)
                    .sheet(isPresented: $isShowingRatingSheet) {
                        ratingSheet
                    }
                    
                    // Botão de compartilhar nos Stories
                    Button {
                        isShowingShareSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Compartilhe nos Stories")
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.gray.opacity(0.75))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $isShowingShareSheet) {
                        shareSheet
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
    }
    
    // Sheet de avaliação
    @ViewBuilder
    var ratingSheet: some View {
        VStack(spacing: 12) {
            Text("Avalie: \(peca.titulo)")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            RatingView(rating: $userRating)
            
            Button("Enviar Nota") {
                guard !jaVotou, userRating > 0 && userRating <= 5 else { return }
                
                peca.totalEstrelas += userRating
                peca.numeroAvaliacoes += 1
                try? context.save()
                
                var votadas = UserDefaults.standard.stringArray(forKey: "pecasVotadas") ?? []
                votadas.append(peca.id.uuidString)
                UserDefaults.standard.set(votadas, forKey: "pecasVotadas")
                
                isShowingRatingSheet = false
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .presentationDetents([.fraction(0.40)])
        .presentationDragIndicator(.visible)
    }
    
    // Sheet de compartilhamento
    @ViewBuilder
    var shareSheet: some View {
        VStack(spacing: 12) {
            Text("Compartilhe a peça nos Stories")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Button {
                // lógica para compartilhar nos Stories
            } label: {
                Label("Compartilhar", systemImage: "square.and.arrow.up")
            }
            
            Spacer()
        }
        .padding()
        .presentationDetents([.fraction(0.3)])
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
