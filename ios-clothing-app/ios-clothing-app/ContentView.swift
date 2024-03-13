//
//  ContentView.swift
//  ios-clothing-app
//
//  Created by Kabir Moulana on 3/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Welcome to Home page")
        }
        .padding()
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
