import SwiftUI
import SwiftData
import UIKit

struct PecaDetailView: View {
    let peca: Peca
    @Environment(\.modelContext) private var context
    @Environment(\.openURL) var openURL
    @Environment(\.dismiss) private var dismiss
    
    @State private var userRating: Int = 0
    @State private var isShowingRatingSheet = false
    @State private var isShowingShareSheet = false
    @State private var shareImage: UIImage? = nil
    @State private var votes = [3, 5, 8, 6, 4]
    
    // Verifica se já votou
    private var jaVotou: Bool {
        let votos = UserDefaults.standard.dictionary(forKey: "votosPecas") as? [String: Int] ?? [:]
        return votos[peca.id.uuidString] != nil
    }

    var body: some View {
        VStack(spacing: 0) {
            // Banner superior
            ZStack(alignment: .topLeading) {
                if let data = peca.imagemBack, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 234)
                        .clipped()
                        .background(
                            LinearGradient(colors: [.gray.opacity(1), .clear],
                                           startPoint: .bottom,
                                           endPoint: .top)
                        )
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 234)
                        .background(
                            LinearGradient(colors: [.gray.opacity(1), .clear],
                                           startPoint: .bottom,
                                           endPoint: .center)
                        )
                }
                HStack{
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
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Título e Direção
                    Text(peca.titulo)
                        .font(.title)
                        .bold()
                    
                    Text("DIRIGIDO POR \n\(peca.direcao)")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                        .offset(y:-10)
                    
                    Text(peca.local)
                        .font(.system(size: 9))
                        .foregroundColor(.gray)
                        .offset(y:-20)


                    // Sinopse + Cartaz
                    HStack(alignment: .top, spacing: 20) {
                        ScrollView(.vertical) {
                            Text(peca.sinopse)
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray.opacity(0.7))
                                .frame(width: 150, alignment: .leading)
                        }
                        .frame(height: 200)

                        if let posterData = peca.imagem,
                           let posterImage = UIImage(data: posterData) {
                            Image(uiImage: posterImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 187, height: 271)
                                .clipped()
                                .cornerRadius(8)
                                .padding(.top, 1)
                                .offset(y: -50)

                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 187, height: 271)
                                .overlay(Text("Cartaz").font(.caption))
                                .padding(.top, 1)
                                .offset(y: -50)
                        }
                    }

                    // Gráfico de notas + média
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Média de Notas")
                            .font(.headline)
                            .padding(.bottom, -20)

                        HStack {
                            Text(String(format: "%.1f", peca.nota))
                                .bold()
                            StarsRatingView(rating: peca.nota)
                            Text("(\(peca.numeroAvaliacoes))")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        .offset(x: 1, y: 10)
                        .padding(.top, 4)
                    }

                    Spacer(minLength: 50)

                    // Botão de avaliar (NÃO trava mais a sheet)
                    Button {
                        isShowingRatingSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "star.fill")
                            Text(jaVotou ? "Você já votou" : "Avaliar peça e mais")
                        }
                        .frame(width: 330, height: 40)
                        .background(Color.gray.opacity(0.75))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $isShowingRatingSheet) {
                        ratingSheet
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $isShowingShareSheet) {
            if let image = shareImage {
                ActivityView(activityItems: [image])
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    // MARK: - Sheet de avaliação
    @ViewBuilder
    var ratingSheet: some View {
        VStack(spacing: 12) {
            Text("\(peca.titulo)")
                .font(.headline)
                .multilineTextAlignment(.center)
                .offset(y:7)
            
            Text("\(peca.periodo) de \(peca.curso)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            if !jaVotou {
                RatingView(rating: $userRating)

                Button("Enviar Nota") {
                    guard userRating > 0 && userRating <= 5 else { return }
                    
                    var votos = UserDefaults.standard.dictionary(forKey: "votosPecas") as? [String: Int] ?? [:]
                    votos[peca.id.uuidString] = userRating
                    UserDefaults.standard.set(votos, forKey: "votosPecas")
                    
                    peca.totalEstrelas += userRating
                    peca.numeroAvaliacoes += 1
                    try? context.save()
                    
                    isShowingRatingSheet = false
                }
                .buttonStyle(.borderedProminent)
            } else {
                Text("Você já avaliou esta peça")
                    .foregroundColor(.green)
                    .font(.subheadline)
            }

            Divider()

            Button {
                if let url = URL(string: peca.linkYoutube),
                   UIApplication.shared.canOpenURL(url) {
                    openURL(url)
                }
            } label: {
                Label("Assistir", systemImage: "play.fill")
            }

            Divider()

            Button {
                isShowingRatingSheet = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    shareImage = PosterInstagramView(peca: peca).snapshot()
                    isShowingShareSheet = true
                }
            } label: {
                Label("Compartilhe", systemImage: "square.and.arrow.up")
            }
            
            Spacer()
        }
        .padding()
        .presentationDetents([.fraction(0.40)])
        .presentationDragIndicator(.visible)
    }
}
// MARK: - RatingView
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

// MARK: - Snapshot Extension
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = CGSize(width: 1080, height: 1920)

        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .white

        let window = UIWindow(frame: CGRect(origin: .zero, size: targetSize))
        window.rootViewController = controller
        window.makeKeyAndVisible()

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}

// MARK: - Share Sheet
struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


#Preview {
    let pecaExemplo = Peca(titulo: "Exemplo", sinopse: "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", direcao: "Odílio Carneiro e André Almeida", data: .now, hora: .now, local: "auditorio nilo pecanha", curso: .informatica, periodo: .p1, linkYoutube: "", linkPhotos: "")
    PecaDetailView(peca: pecaExemplo)
}

