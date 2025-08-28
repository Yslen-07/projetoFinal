import Foundation
import SwiftData

// MARK: - Enums

enum Curso: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }

    case informatica = "Informática"
    case edificacoes = "Edificações"
    case telecomunicacoes = "Telecomunicações"
    case mecanica = "Mecânica"
    case eletrotecnica = "Eletrotécnica"
    case quimica = "Química"
}

enum Genero: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }

    case mulher = "Feminino"
    case homem = "Masculino"
}

enum Ano: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }

    case ano2021 = "2021"
    case ano2022 = "2022"
    case ano2023 = "2023"
    case ano2024 = "2024"
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

    case futsal = "Futsal"
    case natacao = "Natação"
    case volei = "Vôlei"
    case basquete = "Basquete"
    case handebol = "Handebol"
    case carimba = "Carimba"
}

enum EstiloDeNado: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    
    case livre = "Livre"
    case peito = "Peito"
    case costa = "Costa"
    case borboleta = "Borboleta"
}


// MARK: - Modelo Jogo

@Model
class Jogo {
    var id: UUID
    var curso1: Curso
    var curso2: Curso
    var categoria: CategoriaEsportiva
    var genero: Genero
    var local: String
    var data: Date
    var placar1: String
    var placar2: String

    init(
        curso1: Curso,
        curso2: Curso,
        categoria: CategoriaEsportiva,
        genero: Genero,
        local: String,
        data: Date,
        placar1: String,
        placar2: String
    ) {
        self.id = UUID()
        self.curso1 = curso1
        self.curso2 = curso2
        self.categoria = categoria
        self.genero = genero
        self.local = local
        self.data = data
        self.placar1 = placar1
        self.placar2 = placar2
    }
}

// MARK: - Extenção Modelo Jogo(Natação)

@Model
class JogoNatacao: Identifiable {
    var id: UUID
    var categoria: CategoriaEsportiva
    var estiloDeNado: EstiloDeNado
    var genero: Genero
    var local: String
    var data: Date
    var quantidadePessoas: String
    var distancia: String
    var tempo: String

    init(
        categoria: CategoriaEsportiva,
        estiloDeNado: EstiloDeNado,
        genero: Genero,
        local: String,
        data: Date,
        quantidadePessoas: String,
        distancia: String,
        tempo: String
    ) {
        self.id = UUID()
        self.categoria = categoria
        self.estiloDeNado = estiloDeNado
        self.genero = genero
        self.local = local
        self.data = data
        self.quantidadePessoas = quantidadePessoas
        self.distancia = distancia
        self.tempo = tempo
    }
}


// MARK: - Modelo Peca

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

    init(
        titulo: String,
        sinopse: String,
        direcao: String,
        data: Date,
        hora: Date,
        local: String,
        curso: Curso,
        periodo: Periodo,
        imagem: Data? = nil,
        imagemBack: Data? = nil,
        linkYoutube: String,
        linkPhotos: String
    ) {
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
// MARK: - Extensão Jogo Natação

extension JogoNatacao{
    var imagemConfronto: String {
        
        switch genero {
        case .homem:
            return "cardNatacao02"
        case .mulher:
            return "cardNatacao01"
        }
    }
}

// MARK: - Extensão do modelo Jogo (imagem do confronto)

extension Jogo {
    var imagemConfronto: String {
        
        if categoria == .natacao {
                    switch genero {
                    case .homem:
                        return "cardNatacao02"
                    case .mulher:
                        return "cardNatacao01"
                    }
                }
        switch (curso1, curso2) {
        case (.informatica, .edificacoes):
            return "infoEdi"
        case (.informatica, .eletrotecnica):
            return "infoEletro"
        case (.informatica, .telecomunicacoes):
            return "infoTele"
        case (.informatica, .quimica):
            return "infoQuim"
        case (.informatica, .mecanica):
            return "infoMeca"
            
        case (.mecanica, .informatica):
            return "MecaInfo"
        case (.mecanica, .telecomunicacoes):
            return "MecaTele"
        case (.mecanica, .edificacoes):
            return "MecaEdi"
        case (.mecanica, .eletrotecnica):
            return "MecaEletro"
        case (.mecanica, .quimica):
            return "MecaQuim"
            
            
        case (.telecomunicacoes, .informatica):
            return "TeleInfo"
        case (.telecomunicacoes, .quimica):
            return "TeleQuim"
        case (.telecomunicacoes, .edificacoes):
            return "TeleEdi"
        case (.telecomunicacoes, .eletrotecnica):
            return "teleEletro"
        case (.telecomunicacoes, .mecanica):
            return "TeleMeca"
            
        case (.edificacoes, .informatica):
            return "EdiInfo"
        case (.edificacoes, .telecomunicacoes):
            return "ediTele"
        case (.edificacoes, .quimica):
            return "ediQuim"
        case (.edificacoes, .mecanica):
            return "ediMeca"
        case (.edificacoes, .eletrotecnica):
            return "ediEletro"
            
        case (.eletrotecnica, .informatica):
            return "EletroInfo"
        case (.eletrotecnica, .telecomunicacoes):
            return "EletroTele"
        case (.eletrotecnica, .mecanica):
            return "EletroMeca"
        case (.eletrotecnica, .quimica):
            return "EletroQuim"
        case (.eletrotecnica, .edificacoes):
            return "EletroEdi"
            
            
        case (.quimica, .informatica):
            return "QuimicaInfo"
        case (.quimica, .telecomunicacoes):
            return  "QuimicaTele"
        case (.quimica, .mecanica):
            return  "QuimicaMeca"
        case (.quimica, .eletrotecnica):
            return  "QuimicaEletro"
        case (.quimica, .edificacoes):
            return  "QuimicaEdi"
            
        default:
            return "padrao"
        }
    }
}
