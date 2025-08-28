//
//  PosterInstagramView.swift
//  projetoFinal
//
//  Created by found on 25/08/25.
//

import SwiftUI
import UIKit

struct PosterInstagramView: View {
    let peca: Peca
    
    var body: some View {
        VStack {
            ZStack {
                // Imagem do poster ou placeholder
                if let posterData = peca.imagem, let posterImage = UIImage(data: posterData) {
                    Image(uiImage: posterImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 234, height: 412)
                        .clipped()
                        .cornerRadius(8)
                        .padding(.bottom, 50)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 234, height: 412)
                        .overlay(Text("Cartaz").font(.caption))
                        .padding(.bottom, 50)
                }
                
                VStack {
                    Spacer()
                        .frame(height: 145)  // empurra o texto para cima, substitui offset

                    VStack {
                        Text("\(peca.periodo) de \(peca.curso) \n apresenta:")
                            .font(
                                Font.custom("SF Pro", size: 14)
                                .weight(.light)
                            )
                            .kerning(0.3)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        Text(peca.titulo)
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 260)
                            .padding(.top, 5)
                        
                        HStack {
                            Rectangle()
                                .frame(width: 94, height: 2)
                                .foregroundColor(.black)
                                .opacity(0.44)
                            
                            Text("Realização")
                                .font(
                                    Font.custom("SF Pro", size: 10)
                                    .weight(.light)
                                )
                                .kerning(0.33)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                            
                            Rectangle()
                                .frame(width: 94, height: 2)
                                .foregroundColor(.black)
                                .opacity(0.44)
                        }
                            Image("IfceLogo_H")
                                .resizable()
                                .frame(width: 100, height: 25)
                    }
                    .frame(width: 300)
                    .padding(.top, 350)
                }
                .frame(maxHeight: .infinity)
                
                
            }
        }
    }
}

    #Preview {
        let exemplo = Peca(

            titulo: "Unidos!",
            sinopse: "Uma peça sobre algo muito interessante.",
            direcao: "Eu",
            data: Date(),
            hora: Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!,
            local: "Teatro Principal",
            curso: .informatica,
            periodo: .p1,
            linkYoutube: "",
            linkPhotos: "https://pt.pngtree.com/free-backgrounds-photos/imagens-bonitas-para-fundos-pictures"
        )
        PosterInstagramView(peca:exemplo)
}
