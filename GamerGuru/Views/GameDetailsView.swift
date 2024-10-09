//
//  GameDetailsView.swift
//  GamerGuru
//
//  Created by Nilton Pontes on 02/10/24.
//

import SwiftUI

struct GameDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var gameListViewModel: GameListViewModel
    var game: Game
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0)
                .edgesIgnoringSafeArea(.all)
            
            if game.name != nil {
                VStack(alignment: .leading) {
                    Text(game.name ?? "Sem nome").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).font(.title).foregroundColor(.white).padding(.bottom, 12).padding(.horizontal, 24)

                    if (game.coverUrl != nil) {
                        AsyncImage(url: URL(string: game.coverUrl!)) {
                            image in image.image?.resizable().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 320).aspectRatio(contentMode: .fill)
                        }
                    } else {
                        Image("placeholder").resizable().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 320).aspectRatio(contentMode: .fill)                }
                    Text(game.summary ?? "Sem resumo").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).font(.callout).foregroundColor(.white).padding(.vertical, 24).padding(.horizontal, 24)
                    Divider().background(.white).padding(.horizontal, 24)

                        Text("Gênero: " + (gameListViewModel.genresList.filter({ genre in
                                return genre.id == game.genres?.first
                            }).first?.name ?? "-")).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).font(.title3).foregroundColor(.white)
                        

                        Text("Plataformas: " + gameListViewModel.platformsList.filter({ genre in
                                    return game.platforms?.contains(genre.id) ?? false
                                }).map { platform in
                                    return platform.name
                                }.joined(separator: " - ")).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).font(.title3).foregroundColor(.white).italic().padding(.bottom, 8)

                }.padding(0).padding(.top, 72)
            } else {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).frame(maxWidth: .infinity, maxHeight: .infinity).controlSize(.large)
            }
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

// #Preview {
//    GameDetailsView()
// }
