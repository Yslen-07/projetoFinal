//
//  HomePageView.swift
//  projetoFinal
//
//  Created by found on 15/07/25.
//

import SwiftUI

struct HomePageView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
          
            Text("Tela Inicial")
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        Text("Eventos")
                    }
                }
                .tag(0)
            
           
            Text("Tela de esportes")
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 1 ? "volleyball" : "volleyball")
                        Text("Esportes")
                    }
                }
                .tag(1)
            
       
            Text("Tela da JAC")
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 2 ? "theatermasks" : "theatermasks")
                        Text("JAC")
                    }
                }
                .tag(2)
            
            Text("Tela de administrador")
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 2 ? "person.badge.key" : "person.badge.key")
                        Text("Administrador")
                    }
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
#Preview {
    HomePageView()
}
