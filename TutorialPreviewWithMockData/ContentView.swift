//
//  ContentView.swift
//  TutorialPreviewWithMockData
//
//  Created by Sarath Sasikala on 12/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "iphone.sizes")
                .resizable()
                .foregroundStyle(.tint)
                .frame(width: 50, height: 50)
            Text("This project focuses on Xcode previews and mock data. To preview mocked content, check out UserProfileView in the canvas.")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
