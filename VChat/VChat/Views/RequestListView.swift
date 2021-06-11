//
//  ContentView.swift
//  VChat
//
//  Created by Ben Zhang on 6/9/21.
//

import SwiftUI
import Combine

func convertDateToString(unformatted: Date) -> String{
    let dateFormatter = DateFormatter()

    // Set Date Format
    dateFormatter.dateFormat = "M/dd/yy H:mma"

    // Convert Date to String
    let formatted = dateFormatter.string(from: unformatted)
    
    return formatted
}
func displayDateString(unformatted: String) -> String {
    var tempDate: String
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "M/dd/yy H:mma"
    
    if let date = dateFormatterGet.date(from: unformatted) {
        tempDate = (dateFormatterPrint.string(from: date))
        //var formattedDate = date
        
    } else {
       print("There was an error decoding the string")
        tempDate = ""
        
    }
    return tempDate
}

struct RequestListView: View {
    @ObservedObject var requestListViewModel: RequestListViewModel
    @State private var showingSheet = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(requestListViewModel.requestViewModels) {requestVM in
                        RequestView(requestViewModel: requestVM)
                            .onLongPressGesture(minimumDuration: 2) {
                                
                                var callRequest = requestVM.callRequest
                                //print("MONKEY LONG PRESS")
                                    
                                
                                
                                //requestListViewModel.update(callRequest)
                                    
                            }
                            .contextMenu {
                                
                                var callRequest = requestVM.callRequest
                                Button(action: {
                                    
                                    requestListViewModel.remove(callRequest)
                                    //RequestListView.delete(requestViewModel.callRequest)
                                    //RequestViewModel.remove(requestViewModel.callRequest)
                                }) {
                                    Image(systemName: "trash")
                                    
                                }
                            }
                            
                    }.onDelete(perform: delete)
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Calls")
            
            
        }
        Button(action: {
            showingSheet = true
        }) {
            Circle()
                .fill(Color.green)
                .frame(height: 60)
                .overlay(Image(systemName: "plus").foregroundColor(.white))
        }.sheet(isPresented: $showingSheet) {
            SheetView { (callRequest) in
                requestListViewModel.add(callRequest)
                requestListViewModel.update(callRequest)
                showingSheet = false
            }
            
        }
        .padding()
    }
    
    func delete(at offsets: IndexSet) {
        offsets.map { requestListViewModel.requestViewModels[$0].callRequest
            }.forEach(requestListViewModel.remove)
    }
    
}
    
struct RequestListView_Previews: PreviewProvider {
    static var previews: some View {
        RequestListView(requestListViewModel: RequestListViewModel())
    }
}
