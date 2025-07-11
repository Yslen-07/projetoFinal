import SwiftUI

struct ContentView: View {
    @State private var mostrandoForm = false

    var body: some View {
        NavigationStack {
            ListaPecasView() 
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            mostrandoForm = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $mostrandoForm) {
                    PecaFormView()
                }
        }
    }
}

#Preview {
    ContentView()
}

