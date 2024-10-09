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
                        Text("Boas-vindas ao GamerGuru")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .multilineTextAlignment(.center)
                    }
                    VStack(alignment: .center) {
                        NavigationLink(destination: GameListView().environmentObject(gameListViewModel)) {
                            Text("Jogos").font(.title).foregroundColor(.white).padding(16)
                        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding(.horizontal, 40).padding(.top, 0).padding(.bottom, 4).cornerRadius(8.0).background(.ultraThinMaterial).cornerRadius(16.0)
                        Divider().frame(maxWidth: 72)
                        NavigationLink(destination: GenresView().environmentObject(gameListViewModel)) {
                            Text("Gêneros").font(.title).foregroundColor(.white).padding(16)
                        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding(.horizontal, 40).padding(.top, 0).padding(.bottom, 4).cornerRadius(8.0).background(.ultraThinMaterial).cornerRadius(16.0)
                    }.padding(16)
                }.onAppear {
                    if gameListViewModel.genresList.isEmpty {
                        gameListViewModel.getGenres()
                    }
                    if gameListViewModel.platformsList.isEmpty {
                        gameListViewModel.getPlatforms()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
