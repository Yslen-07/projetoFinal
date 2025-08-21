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
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    if !jogosHoje.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("SEC")
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
                    }
                    
             
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("JAC")
                                .font(.headline)
                                .foregroundColor(.blue)
                            
                            Spacer()
                            
                            NavigationLink("Ver mais") {
                                CarouselEventoshj()
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                        
                        CarouselEventoshj()
                            .frame(height: 380)
                    }

                    
                }
            }
            .navigationTitle("Eventos")
        }
    }
}
