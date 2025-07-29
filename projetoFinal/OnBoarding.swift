import SwiftUI

enum OnboardingPage: Int, CaseIterable {
    case APEC
    case Esportes
    case Teatro
    
    var title: String {
        switch self {
        case .APEC:
            return "Bem vindo ao APEC"
        case .Esportes:
            return "Fique por dentro da SEC"
        case .Teatro:
            return "Eventos culturais"
        }
    }

    var description: String {
        switch self {
        case .APEC:
            return "Fique por dentro da semana esportiva  e cultural do IFCE campus Fortaleza"
        case .Esportes:
            return "Descubra como seu curso está indo nos esportes. Pontuação, locais e horários."
        case .Teatro:
            return "Descubra tudo sobre a JAC amostra Interdisciplinar Juventude, Arte e Ciência (JAC) e muito mais!!"
        }
    }
}

struct OnBoardingView: View {
    @State private var currentPage = 0
    @State private var isAnimating = false
    @State private var deliveryOffset = false
    @State private var trackingProgress: CGFloat = 0.0
    @State private var navigateToHome = false  // Controle para navegação

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                        getPageView(for: page)
                            .tag(page.rawValue)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.spring(), value: currentPage)

                // Page Indicator
                HStack(spacing: 12) {
                    ForEach(0..<OnboardingPage.allCases.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.black.opacity(0.8) : Color.gray.opacity(0.5))
                            .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.bottom, 20)

                // Botão Próximo / Iniciar
                Button {
                    withAnimation(.spring()) {
                        if currentPage < OnboardingPage.allCases.count - 1 {
                            currentPage += 1
                            isAnimating = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isAnimating = true
                            }
                        } else {
                            // Navegar para HomePage aqui
                            navigateToHome = true
                        }
                    }
                } label: {
                    Text(currentPage < OnboardingPage.allCases.count - 1 ? "Próximo" : "Iniciar")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)

                
                NavigationLink(destination: HomePageView(), isActive: $navigateToHome) {
                    EmptyView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation {
                        isAnimating = true
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    @ViewBuilder
    private func getPageView(for page: OnboardingPage) -> some View {
        VStack(spacing: 30) {
            // Imagem animada
            ZStack {
                switch page {
                case .APEC:
                    SecImageGroup
                case .Esportes:
                    SportAnimation
                case .Teatro:
                    playAnimation
                }
            }
            // Texto do título e descrição
            VStack(spacing: 20) {
                Text(page.title)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)

                Text(page.description)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
            }
        }
        .padding(.top, 50)
    }

    private var SecImageGroup: some View {
        ZStack {
            Image("SEC")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .offset(y: deliveryOffset ? -20 : 0)
                .opacity(isAnimating ? 1 : 0)
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimating)
        }
    }
    private var SportAnimation: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            Image("Soccer")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .offset(y: deliveryOffset ? -20 : 0)
                .rotationEffect(.degrees(deliveryOffset ? 5 : -5))
                .opacity(isAnimating ? 1 : 0)
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimating)
        }
    }
    private var playAnimation: some View {
        ZStack {
            Image("Group 1")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .opacity(isAnimating ? 1 : 0)
                .scaleEffect(isAnimating ? 1 : 0.8)
                .rotation3DEffect(.degrees(isAnimating ? 360 : 1), axis: (x: 0, y: 1, z: 0))
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimating)
        }
    }
}

// Preview (pode ajustar para testar)
#Preview {
    OnBoardingView()
}
