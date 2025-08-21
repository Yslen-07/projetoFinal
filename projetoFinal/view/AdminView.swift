import SwiftUI

struct AdminView: View {
    @State private var isPasswordVisible = false

    @State private var isShowingSheetEsportes = false
    @State private var showingLoginScreenEsportes = false
    @State private var loginSuccessEsportes = false

    @State private var isShowingSheetJAC = false
    @State private var showingLoginScreenJAC = false
    @State private var loginSuccessJAC = false

    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float = 0

    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.17, green: 0.49, blue: 0.84).opacity(0.15))
                    .frame(width: 344, height: 607)

                VStack(spacing: 16) {
                    Image("working draw")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 258, height: 257)
                        .padding(.top, 30)

                    Text("Administrador")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .frame(width: 200, height: 18, alignment: .topLeading)

                    Text("Esta seção é destinada exclusivamente para administradores")
                        .font(.custom("SF Pro Rounded", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42))
                        .frame(width: 332, height: 100)

                    Spacer()

                    // Botão ESPORTES
                    Button(action: {
                        clearLoginFields()
                        isShowingSheetEsportes = true
                    }) {
                        Text("SEC")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    .frame(width: 200)
                    .sheet(isPresented: $isShowingSheetEsportes, onDismiss: handleDismissEsportes) {
                        loginSheetEsportes
                    }

                    NavigationLink(destination: ContentSecView(), isActive: $showingLoginScreenEsportes) {
                        EmptyView()
                    }

                    // Botão JAC
                    Button(action: {
                        clearLoginFields()
                        isShowingSheetJAC = true
                    }) {
                        Text("JAC")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    .frame(width: 200)
                    .sheet(isPresented: $isShowingSheetJAC, onDismiss: handleDismissJAC) {
                        loginSheetJAC
                    }

                    NavigationLink(destination: ContentJacView(), isActive: $showingLoginScreenJAC) {
                        EmptyView()
                    }

                    Spacer().frame(height: 30)
                }
                .frame(width: 344, height: 607)
            }
            .padding()
        }
    }

    // Login Sheet Esportes → amarelo + vermelho
    var loginSheetEsportes: some View {
        loginSheet(
            title: "Administrador de Esportes",
            loginAction: authenticateUserEsportes,
            gradientColors: [Color.yellow, Color.red]
        )
    }

    // Login Sheet JAC → amarelo + azul
    var loginSheetJAC: some View {
        loginSheet(
            title: "Administrador da JAC",
            loginAction: authenticateUserJAC,
            gradientColors: [Color.yellow, Color.blue]
        )
    }

    // Login Sheet Reutilizável
    func loginSheet(title: String, loginAction: @escaping () -> Void, gradientColors: [Color]) -> some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: gradientColors),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()

            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.4))
            Circle()
                .scale(1.35)
                .foregroundColor(.white.opacity(0.7))

            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .border(.red, width: CGFloat(wrongPassword))

                Button("Login") {
                    loginAction()
                }
                .bold()
                .foregroundColor(.black)
                .frame(width: 300, height: 50)
                .background(gradientColors.first ?? .blue)
                .cornerRadius(10)
            }
        }
        .navigationBarHidden(true)
    }

    // Autenticação SEC
    func authenticateUserEsportes() {
        if username.lowercased() == "caefadm" {
            wrongUsername = 0
            if password == "caef" {
                wrongPassword = 0
                loginSuccessEsportes = true
                isShowingSheetEsportes = false
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }

    // Autenticação JAC
    func authenticateUserJAC() {
        if username.lowercased() == "jacadmin" {
            wrongUsername = 0
            if password == "jac" {
                wrongPassword = 0
                loginSuccessJAC = true
                isShowingSheetJAC = false
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }

    func handleDismissEsportes() {
        if loginSuccessEsportes {
            showingLoginScreenEsportes = true
            loginSuccessEsportes = false
        }
    }

    func handleDismissJAC() {
        if loginSuccessJAC {
            showingLoginScreenJAC = true
            loginSuccessJAC = false
        }
    }

    func clearLoginFields() {
        username = ""
        password = ""
        wrongUsername = 0
        wrongPassword = 0
    }
}

#Preview {
    AdminView()
}
