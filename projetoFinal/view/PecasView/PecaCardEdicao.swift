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
            PecaEditingView(peca: peca) // ← sua view de edição
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
                Text(peca.titulo)
                    .font(.title2.bold())
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
            }
            .padding()
        }
        .cornerRadius(20)
        .shadow(radius: 8)
    }
    
    var backView: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Direção: \(peca.direcao)")
                    .foregroundColor(.gray)
                Text("Data: \(peca.data.formatted(date: .abbreviated, time: .omitted))")
                    .foregroundColor(.gray)
                Text("Hora: \(peca.hora.formatted(date: .omitted, time: .shortened))")
                    .foregroundColor(.gray)
                Text("Local: \(peca.local)")
                    .foregroundColor(.gray)
                
                Spacer()
                
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
                }
                .padding()
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            .cornerRadius(20)
            .shadow(radius: 8)
        }
    }
}
