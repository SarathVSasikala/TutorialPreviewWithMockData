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
    UserProfileView(user: User.mock(.success)!)
}

#Preview("Required Fields Profile") {
    UserProfileView(user: User.mock(.requiredFields)!)
}

#Preview("Student Profile") {
    UserProfileView(user: User.mock(.student)!)
}
