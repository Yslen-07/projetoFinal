//
//  jacProjetoFinal.swift
//  projetoFinal
//
//  Created by Found on 11/07/25.
//

import Foundation
import SwiftData

@Model
class Peca: Identifiable {
    var id: UUID
    var titulo: String
    var sinopse: String
    var direcao: String
    var elenco: String
    var data: Date
    var hora: Date
    var local: String

    init(titulo: String, sinopse: String, direcao: String, elenco: String, data: Date, hora: Date, local: String) {
        self.id = UUID()
        self.titulo = titulo
        self.sinopse = sinopse
        self.direcao = direcao
        self.elenco = elenco
        self.data = data
        self.hora = hora
        self.local = local
    }
}
