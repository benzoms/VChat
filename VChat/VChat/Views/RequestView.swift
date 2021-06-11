//
//  RequestView.swift
//  VChat
//
//  Created by Ben Zhang on 6/9/21.
//

import Foundation
import SwiftUI

struct RequestView: View {
    var requestViewModel: RequestViewModel
    
    var body: some View {
         RoundedRectangle(cornerRadius: 6)
            //.fill(Color(red: 192, green: 192, blue: 192))
            .fill(Color.blue)
            .frame(height: 60)
            .overlay(
                ZStack {
                    HStack {
                        
                        Text(requestViewModel.callRequest.username)
                        Spacer()
                        Text(requestViewModel.callRequest.scheduledTime)
                            .font(.system(size: 16))
                        Spacer()
                        Text("$" + String(requestViewModel.callRequest.price))
                            .foregroundColor(Color.red)
                            .font(.system(size: 14))
                        Spacer()
                        Button(action: {
                            print("Edit button was tapped")
                            //RequestListView.delete(requestViewModel.callRequest)
                            //RequestViewModel.remove(requestViewModel.callRequest)
                        }) {
                            Image(systemName: "trash")
                            
                        }
                        
                    }
                    .padding()
                    
                    
                }
            )
        
    }
}
