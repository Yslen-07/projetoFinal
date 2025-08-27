import SwiftUI
import SwiftData
import UserNotifications

@main
struct ProjetoFinalApp: App {
    
    @StateObject var pecaViewModel = PecaViewModel()
    @StateObject var jogoViewModel = SecViewModel()
    
    init() {
        // Pedir permissão para notificações
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("Permissão concedida: \(granted)")
        }
        UIApplication.shared.registerForRemoteNotifications()
        
        // Set delegate para receber notificações em foreground
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }

    var body: some Scene {
        WindowGroup {
            OnBoardingView()
                .environmentObject(pecaViewModel)
                .environmentObject(jogoViewModel)
        }
        .modelContainer(for: [Jogo.self, Peca.self])
    }
}

// Classe delegate para lidar com notificações em foreground
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationDelegate()
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        
        // Disparar fetch automático
        NotificationCenter.default.post(name: NSNotification.Name("novaPeca"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("novoJogo"), object: nil)
    }
}
