//
//  RequestListViewModel.swift
//  VChat
//
//  Created by Ben Zhang on 6/9/21.
//

import Foundation
import Combine

final class RequestListViewModel: ObservableObject {
    
    @Published var requestRepository = RequestRepository()
    @Published var requestViewModels: [RequestViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        requestRepository.$videoChatRequests
            .map { callRequests in
                callRequests.map(RequestViewModel.init)
            }
            .assign(to: \.requestViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func add(_ callRequest: CallRequest) {
        requestRepository.add(callRequest)
    }
    
    func remove(_ callRequest: CallRequest) {
        requestRepository.remove(callRequest)
    }
    
    func update(_ callRequest: CallRequest) {
        requestRepository.update(callRequest)
    }
}
