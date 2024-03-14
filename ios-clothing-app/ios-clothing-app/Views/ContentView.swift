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
            
            Text("Search View")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)
            Text("Cart View")
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
        .tint(.white)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
