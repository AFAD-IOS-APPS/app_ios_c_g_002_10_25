//
//  WebPresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 10/12/2025.
//

import Foundation
import FirebaseFirestore

final class WebPresenter {
    weak var view: WebViewProtocol?
    var coordinator: WebCoordinator
    
    private let database = Firestore.firestore()
    private let databaseKey: String = "url"

    init(coordinator: WebCoordinator) {
        self.coordinator = coordinator
    }
    
    var savedURL: String? {
        get { UserDefaultsManager.shared.savedURL }
        set { UserDefaultsManager.shared.savedURL = newValue }
    }
    
    func viewDidLoad() async {
        if let savedURL = savedURL {
            openWebView(with: savedURL)
        } else {
            await startFirebaseGateCheck()
        }
    }
    
    func startFirebaseGateCheck() async {
        do {
            let snapshot = try await database.collection("files").getDocuments()
            for document in snapshot.documents {
                let data = document.data()
                if let domain = data[databaseKey] as? String {
                    let baseDomain = domain.components(separatedBy: "/").first ?? ""
                    view?.updateBaseDomain(baseDomain)
                    
                    launchWeb(domain: domain)
                } else {
                    print("Error retrieving data")
                    startMainFlow()
                }
            }
        } catch {
            print("Error getting documents: \(error)")
            startMainFlow()
        }
    }
    
    func startMainFlow() {
        DispatchQueue.main.async {
            self.coordinator.startMainFlow()
        }
    }
        
    private func launchWeb(domain: String) {
        let uuid = getUUID()
        let url = "https://\(domain)/?zhyvv=\(uuid)"
        openWebView(with: url)
    }
    
    private func openWebView(with urlString: String) {
        guard let url = URL(string: urlString) else {
            startMainFlow()
            return
        }

        let request = URLRequest(url: url)
        view?.loadWebView(with: request)
    }
    
    private func getUUID() -> String {
        if let uuid = UserDefaultsManager.shared.userId {
            return uuid
        }
        
        let uuid = UUID().uuidString
        UserDefaultsManager.shared.userId = uuid
        return uuid
    }
}
