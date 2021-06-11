//
//  RequestRepository.swift
//  VChat
//
//  Created by Ben Zhang on 6/9/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class RequestRepository: ObservableObject {
    private let path = "videoChatRequests"
    private let store = Firestore.firestore()
    @Published var videoChatRequests: [CallRequest] = []
    
    init() {
        get()
    }
    
    func get() {
        store.collection(path).addSnapshotListener{ (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.videoChatRequests = snapshot?.documents.compactMap {
                try? $0.data(as: CallRequest.self)
            } ?? []
        }
    }
    
    func add(_ callRequest: CallRequest){
        do {
            _ = try store.collection(path).addDocument(from: callRequest)
        } catch {
            fatalError("Adding a study card failed")
        }
    }
    
    func remove(_ callRequest: CallRequest){
        guard let documentId = callRequest.id else { return }
        store.collection(path).document(documentId).delete() { error in
            if let error = error {
                print("Unable to remove request: \(error.localizedDescription)")
            }
        }
    }
    
    func update(_ callRequest: CallRequest){
        guard let documentId = callRequest.id else { return }
        do {
            try store.collection(path).document(documentId).setData(from: callRequest)
        } catch {
            fatalError("Updating a requests failed")
        }
    }
    
}
