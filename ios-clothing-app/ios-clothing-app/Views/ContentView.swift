//
//  ContentView.swift
//  ios-clothing-app
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            //Button bar
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)
            
            CartView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Cart")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)
            Text("Profile View")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)
        }
        .tint(.black)
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
