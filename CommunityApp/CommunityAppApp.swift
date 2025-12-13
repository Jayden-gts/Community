//
//  CommunityAppApp.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseStorage

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      let storage = Storage.storage()
      print(storage.reference().bucket)


    return true
  }
}


@main
struct CommunityAppApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                //MainTabView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
                
                RootView()
                    .environmentObject(session)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
