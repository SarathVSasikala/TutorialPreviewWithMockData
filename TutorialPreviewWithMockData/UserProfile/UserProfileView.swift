//
//  UserProfileView.swift
//  TutorialPreviewWithMockData
//
//  Created by Sarath Sasikala on 16/10/2023.
//

import SwiftUI

struct UserProfileView: View {
    @State var user: User
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if let isStudent = user.isStudent {
                        if isStudent {
                            Image(systemName: "graduationcap.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                                .padding()
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.green)
                                .padding()
                        }
                    }
                }
                
                Form {
                    Section(header: Text("User Details")) {
                        HStack {
                            Text("Name")
                            Spacer()
                            Text(user.name)
                        }
                        
                        HStack {
                            Text("Age")
                            Spacer()
                            Text(String(user.age))
                        }
                        
                        if let email = user.email {
                            HStack {
                                Text("Email")
                                Spacer()
                                Text(email)
                            }
                        }
                        
                        HStack {
                            Text("Gender")
                            Spacer()
                            Text(user.gender ?? "N/A")
                        }
                    }
                }
                .navigationBarTitle("User Details")

            }

        }
    }
}


#Preview("Success Profile") {
    UserProfileView(user: User(name: "John Doe", age: 25, email: "johndoe@example.com", isStudent: false, gender: "male"))
}

#Preview("Required Fields Profile") {
    UserProfileView(user: User(name: "Jane Smith", age: 30))
}

#Preview("Student Profile") {
    UserProfileView(user: User(name: "Alice Johnson", age: 21, email: "alice@example.com", isStudent: true, gender: "female"))
}
