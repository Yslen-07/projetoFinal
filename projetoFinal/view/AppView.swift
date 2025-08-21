//
//  AppView.swift
//  projetoFinal
//
<<<<<<< HEAD
//  Created by Kamylly Ferreira da Paixão on 31/07/25.
//
=======

>>>>>>> main

import SwiftUI

struct AppView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        if hasSeenOnboarding {
            TabView {
                PecaView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Início")
                    }
                CategoriasView()
                    .tabItem {
                        Image(systemName: "sportscourt")
                        Text("Esportes")
                    }
                AdminView()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Admin")
                    }
<<<<<<< HEAD
                // outras abas aqui...
            }
        } else {
            OnBoardingView {
                hasSeenOnboarding = true
            }
=======
                
            }
        } else {
            OnBoardingView()
        
>>>>>>> main
        }
    }
}

#Preview {
    AppView()
}
