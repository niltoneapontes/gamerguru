//
//  GenresView.swift
//  GamerGuru
//
//  Created by Nilton Pontes on 02/10/24.
//

import SwiftUI

struct GenresView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var gameListViewModel: GameListViewModel
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("List of Genres").font(.largeTitle).foregroundColor(.white)
                Spacer()
                
                if (gameListViewModel.genresList.count == 0) {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).frame(maxWidth: .infinity, maxHeight: .infinity).controlSize(.large).task {
                        do {
                            gameListViewModel.getGenres()
                        }
                    }
                } else {
                    List(gameListViewModel.genresList) { genre in
                        Text(genre.name).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                            .background(.clear)
                            .shadow(radius: 10)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }.listRowSpacing(20.0)
                    .scrollContentBackground(.hidden)
                    .onAppear {
                        gameListViewModel.getGenres()
                    }
                }
            }.padding(.top, 72)
            .padding(.bottom, 48)
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
    GenresView()
}
