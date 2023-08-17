//
//  SettingsView.swift
//  FrenchApp
//
//  Created by Andrea on 7/26/23.
//

import SwiftUI
import Authenticator

struct SettingsView: View {
    
    let personalURL = URL(string:"https://github.com/andrearamonroy")!
    
    var body: some View {
        
        NavigationView {
            
            Authenticator { state in
                List {
                    Section(header: Text("Developer")){
                        VStack(alignment: .leading) {
                            Image("pic2")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            Text("This app was developed by Andrea Monroy. It implements SwiftUI and is written in Swift. The backend was built using AWS services. The app benefits from multi-threading and publishers/subscribers.")
                            Link("Visit my Github 👩🏻‍💻 ", destination: personalURL)
                        }
                    }
                    
                    Section(header: Text("Review")){
                        Text("Leave a review send comment to me")
                        Text("Link to apple review starts")
                    }
                    
                    Section(header: Text("Log out")){
                        Button("Log out") {
                            Task {
                                await state.signOut()
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
//                .navigationBarBackButtonHidden(true)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        BackButton()
//                    }
//                }
            }
            
        }
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
