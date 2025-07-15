import Foundation
import SwiftData

enum Categoria: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }

    case natacao = "Natação"
    case futebol = "Futebol"
    case volei = "Vôlei"
    case basquete = "Basquete"
    case handebol = "Handebol"
    case carimba = "Carimba"
    case xadrez = "Xadrez"
}

@Model
class Jogo: Identifiable {
    //var titulo: String
    var curso1: String
    var curso2: String
    var categoria: Categoria
    var local: String
    var data: Date

    init(/*titulo: String*/ curso1: String, curso2: String, categoria: Categoria, local: String, data: Date) {
        //self.titulo = titulo
        self.curso1 = curso1
        self.curso2 = curso2
        self.categoria = categoria
        self.local = local
        self.data = data
    }
}
