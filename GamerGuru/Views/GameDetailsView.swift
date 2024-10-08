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
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if (gameListViewModel.getSelectedGame().coverUrl != nil) {
                    AsyncImage(url: URL(string: gameListViewModel.getSelectedGame().coverUrl!)) {
                        image in image.image?.resizable().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).aspectRatio(contentMode: .fit)
                    }
                } else {
                    Image("placeholder").resizable().aspectRatio(contentMode: .fit)
                }
                Text(gameListViewModel.getSelectedGame().name ?? "Sem nome").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).font(.title).foregroundColor(.white).padding(.vertical, 24).padding(.horizontal, 24)
                Text(gameListViewModel.getSelectedGame().summary ?? "Sem resumo").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).font(.title2).foregroundColor(.white).padding(.bottom, 32).padding(.horizontal, 24)
                Spacer()
                if(gameListViewModel.genresList.count != 0) {
                    Text("Main genre: " + (gameListViewModel.genresList.filter({ genre in
                        return genre.id == gameListViewModel.getSelectedGame().genres?.first
                    }).first?.name ?? "-")).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).font(.title3).foregroundColor(.white)
                }
                Divider().background(.white)
                    if(gameListViewModel.platformsList.count != 0) {
                        Text(gameListViewModel.platformsList.filter({ genre in
                            return gameListViewModel.getSelectedGame().platforms?.contains(genre.id) ?? false
                        }).map { platform in
                            return platform.name
                        }.joined(separator: " - ")).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).font(.title3).foregroundColor(.white).italic()
                    }
                Spacer()
            }.padding(0)
        }
    }
}

// #Preview {
//    GameDetailsView()
// }
