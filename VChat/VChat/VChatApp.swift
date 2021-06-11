//
//  VChatApp.swift
//  VChat
//
//  Created by Ben Zhang on 6/9/21.
//

import SwiftUI
import Firebase

@main
struct VChatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RequestListView(requestListViewModel: RequestListViewModel())
        }
    }
}
