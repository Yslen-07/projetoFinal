//
//  SecViewModel.swift
//  projetoFinal
//
//  Created by Kamylly Ferreira da Paixão on 26/08/25.
//

import SwiftUI
import CloudKit
import Combine

class SecViewModel: ObservableObject {
    @Published var jogos: [Jogo] = []

    init() {
        fetchJogos()
        subscribeToJogos()
    }
    func fetchJogos() {
        let database = CKContainer.default().publicCloudDatabase
        let query = CKQuery(recordType: "Jogo", predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { records, error in
            if let records = records {
                let fetched = records.compactMap { Jogo(record: $0) }
                DispatchQueue.main.async {
                    self.jogos = fetched
                }
            } else {
                print("Erro ao buscar jogos: \(error?.localizedDescription ?? "")")
            }
        }
    }
    func subscribeToJogos() {
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
}
