//
//  PecaViewModel.swift
//  projetoFinal
//
//  Created by Kamylly Ferreira da Paixão on 26/08/25.
//
import SwiftUI
import CloudKit
import Combine

class PecaViewModel: ObservableObject {
    @Published var pecas: [Peca] = []

    init() {
        fetchPecas()
        subscribeToPecas()
    }
    
    func fetchPecas() {
        let database = CKContainer.default().publicCloudDatabase
        let query = CKQuery(recordType: "Peca", predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { records, error in
            if let records = records {
                let fetched = records.compactMap { Peca(record: $0) }
                DispatchQueue.main.async {
                    self.pecas = fetched
                }
            } else {
                print("Erro ao buscar peças: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func subscribeToPecas() {
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(
            recordType: "Peca",
            predicate: predicate,
            subscriptionID: "newPecaSubscription",
            options: [.firesOnRecordCreation, .firesOnRecordUpdate]
        )
        
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.alertBody = "Nova peça adicionada! Veja mais..."
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
}
