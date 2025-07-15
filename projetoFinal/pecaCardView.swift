import SwiftUI

struct PecaCardView: View {
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            
            if isFlipped {
                MyCard(text: "Viado péssimo amigo", color: .red)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .transition(.opacity)
            } else {
                MyCard(text: "Pec", color: .blue)
                    .transition(.opacity)
            }
        }
        .frame(width: 200, height: 300)
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.6)) {
                isFlipped.toggle()
            }
        }
    }
}

#Preview {
    PecaCardView()
}

struct MyCard: View {
    var text: String
    var color: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .frame(width: 200, height: 300)
                .shadow(radius: 5)
            Text(text)
                .font(.title2)
                .foregroundColor(.yellow)
        }
    }
}
