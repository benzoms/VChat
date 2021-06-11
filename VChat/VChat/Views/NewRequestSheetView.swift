//
//  NewRequestSheetView.swift
//  VChat
//
//  Created by Ben Zhang on 6/9/21.
//

import Foundation
import SwiftUI
import Combine

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var price: String = ""
    @State private var username: String = ""
    @State private var fName: String = ""
    @State private var lName: String = ""
    @State private var timeToCall = Date()
    
    var didAddRequest: (_ callRequest: CallRequest) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Price", text: $price)
                    TextField("Username", text: $username)
                    TextField("Your First Name", text: $fName)
                    TextField("Your Last Name", text: $lName)
                    DatePicker("Enter a date", selection: $timeToCall)
                }
                
                Button("Send VideoChat Request") {
                    let priceint = Int(price)
                    let request = CallRequest(username: username, lastName: lName, firstName: fName, scheduledTime: convertDateToString(unformatted: timeToCall), price: priceint!, profileURL: "String")
                    didAddRequest(request)
                }.disabled(price.isEmpty || username.isEmpty)
                
            }.navigationTitle("Send a Video Chat Request")
            .padding()
        }
        
        
        
    }
}


