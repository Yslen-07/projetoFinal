import SwiftUI

struct AdminView: View {
<<<<<<< HEAD
    @State private var mostrarPecaForm = false
    @State private var mostrarSecForm = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Imagem ilustrativa
                Image("ADM")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)

                // Título
                Text("Administrador")
                    .font(.title)
                    .fontWeight(.bold)

                // Subtítulo
                Text("Esta seção é destinada exclusivamente para administradores")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Texto acima dos botões
                Text("Adicionar evento em…")
                    .font(.headline)
                    .foregroundColor(.blue)

                // Botões customizados
                VStack(spacing: 12) {
                    Button {
                        mostrarSecForm = true
                    } label: {
                        Text("SEC")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .sheet(isPresented: $mostrarSecForm) {
                        SecFormView()
                            .modelContainer(for: Jogo.self)
                    }

                    Button {
                        mostrarPecaForm = true
                    } label: {
                        Text("JAC")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .sheet(isPresented: $mostrarPecaForm) {
                        PecaFormView()
                            .modelContainer(for: Peca.self)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
            .padding(.top, 134)
            .padding(.bottom, 40)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(red: 0.7, green: 0.8, blue: 0.9, opacity: 0.5))
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            )
            .padding(.horizontal)
        }
    }
=======
    
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

    // Login Sheet Esportes → azul + vermelho
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
                    .font(.title) // um pouco menor que .largeTitle
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
>>>>>>> main
}

#Preview {
    AdminView()
}
