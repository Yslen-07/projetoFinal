import SwiftUI


struct HomePage: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            EventosView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Eventos")
                }
                .tag(0)
            
            CategoriasView()
                .tabItem {
                    Image(systemName: "volleyball")
                    Text("SEC")
                }
                .tag(1)

            
            CoverFlowCarouselWithFlipView()
                .tabItem {
                    Image(systemName: "theatermasks")
                    Text("JAC")
                }
                .tag(2)
            
            AdminView()
                .tabItem {
                    Image(systemName: "person.badge.key")
                    Text("Administrador")
                }
                .tag(3)
        }
        .accentColor(corSelecionada)
    }
    
    var corSelecionada: Color {
        switch selectedTab {
        case 0: return .black
        case 1: return .yellow
        case 2: return .red
        case 3: return .blue
        default: return .black
        }
    }
}




//struct HighlightedEventCard: View {
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color(.systemGray6))
//                .shadow(radius: 2)
//            
//            HStack {
//                VStack(alignment: .leading, spacing: 4) {
//                    HStack {
//                        Text("SEC")
//                            .font(.caption2)
//                            .bold()
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 4)
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                            .offset(x: -15, y: -15)
//                        Spacer()
//                        Text("Ver mais >")
//                            .font(.caption)
//                            .foregroundColor(.blue)
//                    }
//                    
//                    HStack {
//                        Text("INFORMÁTICA").fontWeight(.semibold)
//                        Spacer()
//                        Text("VS").fontWeight(.semibold)
//                        Spacer()
//                        Text("MECÂNICA").fontWeight(.semibold)
//                    }
//                    
//                    Text("Vôlei Masculino")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//                .padding()
//            }
//        }
//        .frame(height: 80)
//    }
//}

//struct EventCard: View {
//    let titulo: String
//    let subtitulo: String
//    let imageName: String
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            ZStack(alignment: .topLeading) {
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(Color.gray.opacity(0.2))
//                    .frame(width: 160, height: 230)
//                    .overlay(
//                        Image(imageName)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 160, height: 230)
//                            .clipped()
//                            .cornerRadius(12)
//                    )
//                
//                Text("JAC")
//                    .font(.caption2)
//                    .bold()
//                    .foregroundColor(.white)
//                    .padding(6)
//                    .background(Color.blue)
//                    .cornerRadius(5)
//                    .padding(8)
//                    .offset(x: -8, y: -8)
//            }
//            
//            Text(titulo)
//                .bold()
//                .padding(.top, 4)
//            Text(subtitulo)
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//        .frame(width: 160)
//    }
//}

#Preview {
    HomePage()
}
