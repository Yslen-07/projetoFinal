//
//  PecaCardEdicao.swift
//  projetoFinal
//
//  Created by Found on 30/07/25.
//

import SwiftUI

struct PecaCardEdicao: View {
    let peca: Peca
    @State private var flipped = false
    @State private var mostrandoEdicao = false


    var body: some View {
        ZStack {
            frontView
                .opacity(flipped ? 0 : 1)
            backView
                .opacity(flipped ? 1 : 0)
        }
        .frame(width: 250, height: 380)
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.4), value: flipped)
        .onTapGesture {
            flipped.toggle()
        }
        .sheet(isPresented: $mostrandoEdicao) {
            PecaEditingView(peca: peca)
        }
    }
    
    var frontView: some View {
        ZStack {
            if let data = peca.imagem,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 380)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 250, height: 380)
            }

            VStack {
                Spacer()
                Text("\(peca.titulo)")
                    .frame(width: 250)
                    .font(.headline)
                    .foregroundColor(.white)
                    .offset(x: 35)
                
                
                Text("\(peca.data)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .offset(x: 50)
                    
                
            }
            .offset(x:-50)
            .padding(.bottom, 10)
            .frame(width: 250, height: 90)
            .background(
                LinearGradient(colors: [.black.opacity(1), .clear], startPoint: .bottom, endPoint: .top)
                        )
            .offset(y:145)
        }
        .frame(width: 250, height: 380)
        .cornerRadius(20)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 8)

    }
    
    var backView: some View {
        ZStack {
            VStack(spacing: 16) {
                NavigationLink(destination: PecaDetailView(peca: peca)) {
                    Text("Saiba Mais")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .cornerRadius(20)
                }
                    Button {
                        mostrandoEdicao = true
                    } label: {
                        Label("Editar", systemImage: "pencil")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                .padding()
                
                
            }
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .frame(width: 250, height: 380)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
        }
    }
}
