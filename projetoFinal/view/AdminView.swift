import SwiftUI

struct AdminView: View {
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

                   
                    NavigationLink(destination: SecFormView()) {
                        Text("Esportes")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    .frame(width: 200)
                    .shadow(color: .blue, radius: 5)

                    
                    NavigationLink(destination: PecaFormView()) {
                        Text("JAC")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    .frame(width: 200)
                    .shadow(color: .blue, radius: 5)

                    Spacer().frame(height: 30)
                }
                .frame(width: 344, height: 607)
            }
            .padding()
        }
    }
}
#Preview{
    AdminView()
}
