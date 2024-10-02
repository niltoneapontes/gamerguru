//
//  GameListView.swift
//  GamerGuru
//
//  Created by Nilton Pontes on 02/10/24.
//

import SwiftUI

struct GameListView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var gameListViewModel: GameListViewModel
    @State private var searchText: String = ""
    @State private var showDetail: Bool = false

    var body: some View {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("List of Games").font(.largeTitle).foregroundColor(.white)
                        
                            HStack {
                                TextField(
                                    "Search for a game",
                                    text: $searchText)
                                .padding(16)
                                .disableAutocorrection(true)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .background(.ultraThinMaterial)
                                .cornerRadius(8.0)
                                .border(.secondary)
                                
                                Button(action: {
                                    gameListViewModel.searchGame(searchText: searchText)
                                }) {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 54, maxHeight: 54)
                                }.background(.purple)
                                .cornerRadius(8.0)
                                .padding(.trailing, 10)
                                
                            }.padding(.horizontal, 30)
                                .frame(maxWidth: .infinity, maxHeight: 64)
                        
                        
                        if (gameListViewModel.gamesList.count == 0) {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).frame(maxWidth: .infinity, maxHeight: .infinity).controlSize(.large).task {
                                do {
                                    if(searchText.isEmpty) {
                                        gameListViewModel.getGameList()
                                    }
                                }
                            }
                        } else {
                            List(gameListViewModel.gamesList) { game in
                                VStack(alignment: .center) {
                                    if (game.coverUrl != nil) {
                                        AsyncImage(url: URL(string: game.coverUrl!)) {
                                            image in image.image?.resizable().aspectRatio(contentMode: .fit)
                                        }
                                    } else {
                                        Image("placeholder").resizable().aspectRatio(contentMode: .fit)
                                    }
                                    Text(game.name ?? "Sem nome")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.center)
                                        .padding(8)
                                    Button(action: {
                                        print(game)
                                        gameListViewModel.setSelectedGame(newValue: game)
                                        self.showDetail = true
                                    }) {
                                        Text("See details")
                                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(8.0)
                                    .sheet(isPresented: $showDetail, onDismiss: {
                                        self.showDetail = false
                                    }) {
                                        GameDetailsView()
                                    }
                                }.background(.ultraThinMaterial)
                                    .shadow(radius: 10)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(8.0)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }.listRowSpacing(20.0)
                            .scrollContentBackground(.hidden)
                            .onAppear {
                                if(searchText.isEmpty) {
                                    gameListViewModel.getGameList()
                                }
                            }
                        }
                    }.padding(.top, 72)
                    .padding(.bottom, 20)
                }.navigationBarBackButtonHidden(true)
                .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text("Voltar")
                                    }
                                    .foregroundColor(.white)
                                }
                            }
                        }
        }
}

#Preview {
    GameListView()
}
