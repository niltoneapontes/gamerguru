//
//  ContentView.swift
//  GamerGuru
//
//  Created by Nilton Pontes on 01/10/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var gameListViewModel = GameListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        Image("raccoon").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 200).padding(.bottom, 64)
                        Text("Welcome to GamerGuru")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .multilineTextAlignment(.center)
                    }
                    Text("Select an option:")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.bottom, 12)
                        .multilineTextAlignment(.center)
                    VStack(alignment: .center) {
                        NavigationLink(destination: GameListView().environmentObject(gameListViewModel)) {
                            Text("Games").font(.title).foregroundColor(.white).padding(0).padding(.top, 16)
                        }.padding(.horizontal, 40).padding(.top, 0).padding(.bottom, 4).cornerRadius(8.0)
                        Divider().frame(maxWidth: 72)
                        NavigationLink(destination: GenresView().environmentObject(gameListViewModel)) {
                            Text("Genres").font(.title).foregroundColor(.white).padding(0)
                        }.padding(.horizontal, 40).padding(.top, 0).padding(.bottom, 16).cornerRadius(8.0)
                    }.background(.ultraThinMaterial).cornerRadius(16.0)
                }.onAppear {
                    gameListViewModel.getGenres()
                    gameListViewModel.getPlatforms()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
