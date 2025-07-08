//
//  firstView.swift
//  projetoFinal
//
//  Created by Found on 04/07/25.
//
import Foundation
import SwiftUI

struct secFormView: View {
    @State var secTitle: String = ""
    @State var categoriaSelected: Caategory = .natacao
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Selecione modalidade")){
                                 Picker("Modalidade: ", selection: $categoriaSelected) {
                                   Text("\(Caategory.basquete.rawValue)").tag(Caategory.basquete)
                                    Text("\(Caategory.carimba.rawValue)").tag(Caategory.carimba)
                                  Text("\(Caategory.futsal.rawValue)").tag(Caategory.futsal)
                                   Text("\(Caategory.handbol.rawValue)").tag(Caategory.handbol)
                                      Text("\(Caategory.natacao.rawValue)").tag(Caategory.natacao)
                                     Text("\(Caategory.volei.rawValue)").tag(Caategory.volei)
                                      Text("\(Caategory.xadrez.rawValue)").tag(Caategory.xadrez)
               
               
                                   }
                              }
                Section(header: Text("Modalidade selecionada: \(Caategory.natacao.rawValue)")){
                    switch categoriaSelected {
                    case .natacao:
                        TextField("Tudo sobre a natação...", text: $secTitle)
                    case .carimba:
                        TextField("Tudo sobre a carimba...", text: $secTitle)
                    case .handbol:
                        TextField("Tudo sobre o handbol...", text: $secTitle)
                    case .volei:
                        TextField("Tudo sobre o vôlei...", text: $secTitle)
                    case .basquete:
                        TextField("Tudo sobre o basquete...", text: $secTitle)
                    case .futsal:
                        TextField("Tudo sobre o futsal...", text: $secTitle)
                    case .xadrez:
                        TextField("Tudo sobre o xadrez...", text: $secTitle)
                        
                        
                    }
                    
                    
                }
                
            }
        }
    }
}




#Preview {
    secFormView()
}
