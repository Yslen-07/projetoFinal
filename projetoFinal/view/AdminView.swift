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
                        Text("Esportes")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    .frame(width: 200)
                    .sheet(isPresented: $isShowingSheetEsportes, onDismiss: handleDismissEsportes) {
                        loginSheetEsportes
                    }

                    // Navegação para ContentSecView após login Esportes
                    NavigationLink(destination: ContentSecView(), isActive: $showingLoginScreenEsportes) {
                        EmptyView()
                    }

                    // Botão JAC
                    Button(action: {
                        clearLoginFields()
                        isShowingSheetJAC = true
                    }) {
                        Text("JAC")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    .frame(width: 200)
                    .sheet(isPresented: $isShowingSheetJAC, onDismiss: handleDismissJAC) {
                        loginSheetJAC
                    }

                    // Navegação para ContentJacView após login JAC
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

    // Login Sheet Esportes
    var loginSheetEsportes: some View {
        loginSheet(title: "Login Esportes", loginAction: authenticateUserEsportes)
    }

    // Login Sheet JAC
    var loginSheetJAC: some View {
        loginSheet(title: "Login JAC", loginAction: authenticateUserJAC)
    }

    // Login Sheet Reutilizável
    func loginSheet(title: String, loginAction: @escaping () -> Void) -> some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.60))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)

            VStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .padding()

                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                
                HStack{
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }, label: {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    })
                }
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .border(.red, width: CGFloat(wrongPassword))

                    Button("Login") {
                        loginAction()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
        }
        .navigationBarHidden(true)
    }

    // Autenticação Esportes
    func authenticateUserEsportes() {
        if username.lowercased() == "caef_admin" {
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
        if username.lowercased() == "jac_admin" {
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

    // Handle dismiss login Esportes
    func handleDismissEsportes() {
        if loginSuccessEsportes {
            showingLoginScreenEsportes = true
            loginSuccessEsportes = false
        }
    }

    // Handle dismiss login JAC
    func handleDismissJAC() {
        if loginSuccessJAC {
            showingLoginScreenJAC = true
            loginSuccessJAC = false
        }
    }

    // Limpa os campos ao abrir nova tela
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
