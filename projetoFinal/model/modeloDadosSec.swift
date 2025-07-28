import Foundation
import SwiftData


enum Curso: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }

    case informatica = "Informática"
    case edificacoes = "Edificações"
    case telecomunicacoes = "Telecomunicações"
    case mecanica = "Mecânica"
    case eletrotecnica = "Eletrotécnica"
    case quimica = "Química"
}

enum Periodo: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }

    case p1 = "P1"
    case p2 = "P2"
    case p3 = "P3"
    case p4 = "P4"
    case p5 = "P5"
    case p6 = "P6"
}
enum CategoriaEsportiva: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }

    case natacao = "Natação"
    case futebol = "Futsal"
    case volei = "Vôlei"
    case basquete = "Basquete"
    case handebol = "Handebol"
    case carimba = "Carimba"
    case xadrez = "Xadrez"
}


@Model
class Jogo: Identifiable {
    var id: UUID
    var curso1: Curso
    var curso2: Curso
    var categoria: CategoriaEsportiva
    var local: String
    var data: Date

    init( curso1: Curso, curso2: Curso, categoria: CategoriaEsportiva, local: String, data: Date) {
        self.id = UUID()
        self.curso1 = curso1
        self.curso2 = curso2
        self.categoria = categoria
        self.local = local
        self.data = data
    }
}


@Model
class Peca: Identifiable {
    var id: UUID
    var titulo: String
    var sinopse: String
    var direcao: String
    var linkYoutube: String
    var linkPhotos: String
    var data: Date
    var hora: Date
    var local: String
    var curso: Curso
    var periodo: Periodo
    var imagem: Data?
    var imagemBack: Data?
    
    init(titulo: String, sinopse: String, direcao: String, data: Date, hora: Date, local: String, curso: Curso, periodo: Periodo, imagem: Data? = nil, imagemBack: Data? = nil, linkYoutube: String, linkPhotos: String) {
        self.id = UUID()
        self.titulo = titulo
        self.sinopse = sinopse
        self.direcao = direcao
        self.data = data
        self.hora = hora
        self.local = local
        self.curso = curso
        self.periodo = periodo
        self.imagem = imagem
        self.imagemBack = imagemBack
        self.linkYoutube = linkYoutube
        self.linkPhotos = linkPhotos
    }
}
