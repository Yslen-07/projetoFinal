//
//  EventosHomeTab.swift
//  projetoFinal
//
//  Created by Found on 31/07/25.
//


import SwiftUI

struct EventosHomeTab: View {
    @State private var destaqueIndex = 0
    @State private var eventosIndex = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Eventos")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top)
                    
                    TabView(selection: $destaqueIndex) {
                        ForEach(0..<3) { index in
                            HighlightedEventCard()
                                .padding(.horizontal)
                                .tag(index)
                        }
                    }
                    .frame(height: 150)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .padding(.top)
                    
                    TabView(selection: $eventosIndex) {
                        EventCard(titulo: "UNIDOS!",
                                  subtitulo: "P3 de Informática",
                                  imageName: "unidos_placeholder")
                        .tag(0)
                        
                        EventCard(titulo: "PIRILAM...",
                                  subtitulo: "P5 de Informática",
                                  imageName: "pirilampo_placeholder")
                        .tag(1)
                        
                        EventCard(titulo: "Outro Evento",
                                  subtitulo: "P1 de Informática",
                                  imageName: "placeholder2")
                        .tag(2)
                    }
                    .frame(height: 400)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .padding(.top, 12)
                    
                    Text("Outros")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
            .background(Color(.systemBackground))
        }
    }
}