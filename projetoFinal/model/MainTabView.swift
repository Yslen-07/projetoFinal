//
//  MainTabView.swift
//  projetoFinal
//
//  Created by found on 28/07/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            
           
            EventosHomeTab()
                .tabItem {
                    Image(systemName: "house")
                    Text("Eventos")
                }
                .tag(0)
            
            
            SecAlunoView()
                .tabItem {
                    Image(systemName: "volleyball")
                    Text("SEC")
                }
                .tag(1)
            
           
            PecaView()
                .tabItem {
                    Image(systemName: "theatermasks")
                    Text("JAC")
                }
                .tag(2)
            
            AdminView()
                .tabItem {
                    Image(systemName: "person.badge.key")
                    Text("Administrador")
                }
                .tag(3)
        }

        .accentColor(corSelecionada)
    }

    var corSelecionada: Color {
        switch selectedTab {
        case 0: return .blue
        case 1: return .black
        case 3: return .red     
        default: return .black
        }
    }

}
