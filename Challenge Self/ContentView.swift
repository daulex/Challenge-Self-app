//
//  ContentView.swift
//  Challenge Self
//
//  Created by Kirills Galenko on 26/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("No saved challenges")
                NavigationLink(destination: CreateNewChallengeView()) {
                    Text("Create new challenge")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
