//
//  PecaDetailView.swift
//  projetoFinal
//
//  Created by Found on 18/07/25.
//

import SwiftUI

struct PecaDetailView: View {
    let peca: Peca
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowing = false
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack(alignment: .topLeading) {
                if let data = peca.imagemBack, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .shadow(color: Color.white, radius: 2, x: -2, y: -2)
                        .foregroundStyle(
                        .shadow(.inner(color: .white.opacity(0.3), radius: 3, x: 1, y: 1)))
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 250)
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                        .padding(.top, 50)
                        .padding(.leading, 16)
                }
            }
            
      

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Título
                    Text(peca.titulo)
                        .font(.title)
                        .bold()
                    
                    // Direção
                    Text("DIRIGIDO POR  \(peca.direcao.uppercased())")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Sinopse + Cartaz
                    ScrollView(.vertical){
                        VStack(spacing: 20) {
                            Text(peca.sinopse)
                                .font(
                                    Font.custom("SF Pro", size: 12)
                                        .weight(.medium))
                                .kerning(0.3)
                                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                        }
                    }
                    .frame(width: 200, height: 200, alignment: .leading)
                    // Cartaz à direita
                    HStack{
                        if let posterData = peca.imagem, let posterImage = UIImage(data: posterData) {
                            Image(uiImage: posterImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 137, height: 221)
                                .clipped()
                                .cornerRadius(8)
                                .offset(x:230, y:0)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 137, height: 221)
                                .overlay(Text("Cartaz").font(.caption))
                                .offset(x:230, y:0)
                        }
                    }
                    .offset(x:0, y:-235)
                    
                    // Seção Notas
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notas")
                            .font(.headline)
                        
                        HStack(spacing: 8) {
                            // Barras verticais (exemplo fixo)
                            ForEach(0..<5) { index in
                                Rectangle()
                                    .fill(index == 2 ? Color.gray : Color.gray.opacity(0.3))
                                    .frame(width: 8, height: CGFloat(20 + index * 5))
                                    .cornerRadius(2)
                            }
                            
                            Spacer()
                            
                            // Nota e estrela
                            HStack(spacing: 4) {
                                Text("5")
                                    .font(.headline)
                                ForEach(0..<5) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .offset(x:0, y:-210)
                    
                    VStack {
                                Button {
                                    isShowing.toggle()
                                } label: {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Dê sua nota e compartilhe")
                                    }
                                    .frame(width: 370, height: 40)
                                    .background(Color(red: 0.75, green: 0.74, blue: 0.74))
                                    .cornerRadius(8)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                }
                            }
                            .offset(x: 0, y: -150)
                            .sheet(isPresented: $isShowing) {
                                VStack(spacing: 24) {
                                    Text("\(peca.titulo)")
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                    Text("\(peca.periodo)")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.center)

                                    Button {
                                        // Ação para "Bom"
                                    } label: {
                                        Label("Bom", systemImage: "hand.thumbsup")
                                    }
                                    Divider()

                                    Button {
                                        // Ação para "Assistir"
                                    } label: {
                                        Label("Assistir", systemImage: "play.fill")
                                    }
                                    Divider()
                                    Button {
                                        // Ação para "Ruim"
                                    } label: {
                                        Label("Ruim", systemImage: "hand.thumbsdown")
                                    }
                                    Spacer()
                                }
                                .padding()
                                .presentationDetents([.fraction(0.40)]) // ocupa metade da tela
                                .presentationDragIndicator(.visible)
                            
                        
                    }
                    .offset(x: 0, y: 0)


                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
    }
}
#Preview {
    let pecaExemplo = Peca(titulo: "Exemplo", sinopse: "", direcao: "", data: .now, hora: .now, local: "", curso: .informatica, periodo: .p1)
    PecaDetailView(peca: pecaExemplo)
}

