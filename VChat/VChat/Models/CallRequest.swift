//
//  File.swift
//  VChat
//
//  Created by Ben Zhang on 6/9/21.
//

import Foundation
import FirebaseFirestoreSwift

struct CallRequest: Identifiable, Codable{
    @DocumentID var id: String?
    public var username: String
    public var lastName: String
    public var firstName: String
    public var scheduledTime: String
    public var price: Int
    public var profileURL: String
}
