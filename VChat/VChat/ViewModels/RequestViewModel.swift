//
//  RequestViewModel.swift
//  VChat
//
//  Created by Ben Zhang on 6/9/21.
//

import Foundation
import Combine

final class RequestViewModel: ObservableObject, Identifiable {
    private let requestRepository = RequestRepository()
    @Published var callRequest: CallRequest
    
    var id = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(callRequest: CallRequest) {
        self.callRequest = callRequest
        $callRequest
            .compactMap { $0.id }
            .assign(to: \.id, on:self)
            .store(in: &cancellables)
    }
    
    func remove(_ callRequest: CallRequest) {
        requestRepository.remove(callRequest)
    }
}
