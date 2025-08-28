import SwiftUI
import SwiftData

struct EventosView: View {
    @Query var jogos: [Jogo]
    @Query var pecas: [Peca]

    
    
    var body: some View {
        let hoje = Calendar.current.startOfDay(for: Date())
        let jogosHoje = jogos.filter {
            Calendar.current.isDate($0.data, inSameDayAs: hoje)
        }
        var pecasHoje: [Peca] {
            let hoje = Calendar.current.startOfDay(for: Date())
            return pecas.filter { Calendar.current.isDate($0.data, inSameDayAs: hoje) }
        }
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // --- SEC ---
                    if jogosHoje.isEmpty && pecasHoje.isEmpty{
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("SEC")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                     
                            VStack{
                                Text("Contagem regressiva até o inicio da SEC")
                                    .font(.system(size: 20))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.vertical, 2)
                                CountdownTimerView(endDate: "2025-12-05T00:00:00Z")
                            }
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 200)
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Jogos")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                
                                NavigationLink("Ver mais") {
                                    CategoriasView()
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(jogosHoje) { jogo in
                                        CardInicial(jogo: jogo)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("JAC")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                
                                NavigationLink("Ver mais") {
                                    CoverFlowCarouselWithFlipView()
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                            
                            CarouselEventoshj()
                                .frame(height: 380)
                        }
                    }
                    
                    // --- JAC ---
                   
                }
            }
            .navigationTitle("Eventos")
        }
    }
}
#Preview{
    EventosView()
}
