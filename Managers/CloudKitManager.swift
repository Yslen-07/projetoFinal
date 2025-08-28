//
//  CloudKitManager.swift
//  projetoFinal
//
//  Created by Kamylly Ferreira da Paixão on 26/08/25.
//
import CloudKit

extension Jogo {
    convenience init?(record: CKRecord) {
        guard
            let curso1Raw = record["curso1"] as? String,
            let curso2Raw = record["curso2"] as? String,
            let categoriaRaw = record["categoria"] as? String,
            let generoRaw = record["genero"] as? String,
            let local = record["local"] as? String,
            let data = record["data"] as? Date,
            let placar1 = record["placar1"] as? String,
            let placar2 = record["placar2"] as? String,
            let curso1 = Curso(rawValue: curso1Raw),
            let curso2 = Curso(rawValue: curso2Raw),
            let categoria = CategoriaEsportiva(rawValue: categoriaRaw),
            let genero = Genero(rawValue: generoRaw)
        else {
            return nil
        }

        self.init(
            curso1: curso1,
            curso2: curso2,
            categoria: categoria,
            genero: genero,
            local: local,
            data: data,
            placar1: placar1,
            placar2: placar2
        )
    }

    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: "Jogo")
        record["curso1"] = curso1.rawValue
        record["curso2"] = curso2.rawValue
        record["categoria"] = categoria.rawValue
        record["genero"] = genero.rawValue
        record["local"] = local
        record["data"] = data
        record["placar1"] = placar1
        record["placar2"] = placar2
        return record
    }
}

extension Peca {
    convenience init?(record: CKRecord) {
        guard
            let titulo = record["titulo"] as? String,
            let direcao = record["direcao"] as? String,
            let local = record["local"] as? String,
            let periodoString = record["periodo"] as? String,
            let periodo = Periodo(rawValue: periodoString),
            let cursoString = record["curso"] as? String,
            let curso = Curso(rawValue: cursoString),
            let data = record["data"] as? Date,
            let hora = record["hora"] as? Date,
            let sinopse = record["sinopse"] as? String
        else {
            return nil
        }

        self.init(
            titulo: titulo,
            sinopse: record["sinopse"] as? String ?? "",
            direcao: direcao,
            data: data,
            hora: hora,
            local: local,
            curso: curso,
            periodo: periodo,
            imagem: nil, // converter CKAsset p/ Data
            imagemBack: nil,
            linkYoutube: record["linkYoutube"] as? String ?? "",
            linkPhotos: record["linkPhotos"] as? String ?? "",
        )
    }
    // Converter uma Peca para CKRecord (para salvar no CloudKit)
       func toRecord() -> CKRecord {
           let record = CKRecord(recordType: "Peca")
           record["titulo"] = self.titulo as CKRecordValue
           record["sinopse"] = self.sinopse as CKRecordValue
           record["direcao"] = self.direcao as CKRecordValue
           record["local"] = self.local as CKRecordValue
           record["periodo"] = self.periodo.rawValue as CKRecordValue
           record["curso"] = self.curso.rawValue as CKRecordValue
           record["data"] = self.data as CKRecordValue
           record["hora"] = self.hora as CKRecordValue
           record["linkYoutube"] = self.linkYoutube as CKRecordValue
           record["linkPhotos"] = self.linkPhotos as CKRecordValue
           record["sinopse"] = self.sinopse as CKRecordValue
           return record
       }
   }
func subscribeToNewJogos() {
    let predicate = NSPredicate(value: true)
    let subscription = CKQuerySubscription(
        recordType: "Jogo",
        predicate: predicate,
        subscriptionID: "newJogoSubscription",
        options: [.firesOnRecordCreation, .firesOnRecordUpdate]
    )
    
    let notificationInfo = CKSubscription.NotificationInfo()
    notificationInfo.alertBody = "Novo jogo adicionado! Veja mais..."
    notificationInfo.shouldBadge = true
    notificationInfo.soundName = "default"
    
    subscription.notificationInfo = notificationInfo
    
    CKContainer.default().publicCloudDatabase.save(subscription) { _, error in
        if let error = error {
            print("Erro ao criar subscription: \(error.localizedDescription)")
        } else {
            print("Subscription criada com sucesso!")
        }
    }
}
