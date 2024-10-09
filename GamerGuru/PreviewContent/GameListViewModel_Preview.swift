//
//  ModelData.swift
//  GamerGuru
//
//  Created by Nilton Pontes on 08/10/24.
//

import SwiftUI

// Supondo que você já tenha uma estrutura de `Game`, `Genre`, e `Platform` definida.

struct GameListViewModel_Preview: PreviewProvider {
    static var previews: some View {
        let viewModel = GameListViewModel()
        
        // Adicione alguns jogos de exemplo à lista
        viewModel.gamesList = [
            Game(name: "Example Game 1", id: 1, url: "https://example.com/game1", screenshots: nil, summary: "An example game", platforms: nil, genres: nil),
            Game(name: "Example Game 2", id: 2, url: "https://example.com/game2", screenshots: nil, summary: "Another example game", platforms: nil, genres: nil)
        ]
        
        // Adicione alguns gêneros de exemplo
        viewModel.genresList = [
            Genre(id: 1, name: "Action", url: "https://example.com/genre1"),
            Genre(id: 2, name: "Adventure", url: "https://example.com/genre2")
        ]
        
        // Adicione algumas plataformas de exemplo
        viewModel.platformsList = [
            Platform( id: 1, name: "PlayStation 5"),
            Platform( id: 2, name: "Xbox Series X")
        ]
        
        // Retorne uma view que use o view model
        return GameListView().environmentObject(viewModel)
    }
}
