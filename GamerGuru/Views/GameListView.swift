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
    
    @State private var selectedGame = Game(name: nil, id: nil, url: nil, screenshots: nil, summary: nil, platforms: nil, genres: nil)

    var body: some View {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Lista de Jogos").font(.largeTitle).foregroundColor(.white)
                        
                            HStack {
                                TextField(
                                    "Pesquise aqui",
                                    text: $searchText)
                                .padding(16)
                                .disableAutocorrection(true)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .background(.ultraThinMaterial)
                                .cornerRadius(8.0)
                                .border(.clear)
                                
                                Button(action: {
                                    gameListViewModel.searchGame(searchText: searchText)
                                }) {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 54, maxHeight: 54)
                                }.background(.purple)
                                .cornerRadius(8.0)
                                .padding(.leading, 10)
                            }.padding(.horizontal, 18)
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
                                HStack(alignment: .center) {
                                    if (game.coverUrl != nil) {
                                        AsyncImage(url: URL(string: game.coverUrl!)) {
                                            image in image.image?.resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 120)
                                        }
                                    } else {
                                        Image("placeholder").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 120)
                                    }
                                    NavigationLink(destination: GameDetailsView(game: game).environmentObject(gameListViewModel)) {
                                        VStack(alignment: .center) {
                                            Text(game.name ?? "Sem nome")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                                .multilineTextAlignment(.center)
                                            
                                            
                                            Text("Ver detalhes")
                                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                                .font(.title2).bold()
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                            
                                                .padding(.top, 4)
                                                .frame(maxWidth: .infinity)
                                        }
                                    }.foregroundColor(.white)
                                        .padding(.trailing, 16)
                                        
                                }.background(.ultraThinMaterial)
                                    .shadow(radius: 10)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(8.0)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets())
                            }.listRowSpacing(20.0)
                                .listRowInsets(EdgeInsets())
                            .scrollContentBackground(.hidden)
                            .onAppear {
                                if(searchText.isEmpty) {
                                    gameListViewModel.getGameList()
                                }
                            }
                        }
                    }
                .padding(.top, 72)
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
    GameListViewModel_Preview.previews
}
