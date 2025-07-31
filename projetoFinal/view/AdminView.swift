import SwiftUI

struct AdminView: View {
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
}

#Preview {
    AdminView()
}
