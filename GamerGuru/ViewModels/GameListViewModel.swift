//
//  GameListViewModel.swift
//  GamerGuru
//
//  Created by Nilton Pontes on 01/10/24.
//

import Foundation

class GameListViewModel: ObservableObject {
    @Published var gamesList: [Game] = []
    @Published var genresList: [Genre] = []
    @Published var platformsList: [Platform] = []

    @Published private var selectedGame: Game = Game(name: nil, id: nil, url: nil, screenshots: nil, summary: nil, platforms: nil, genres: nil)

    func setSelectedGame(newValue: Game) {
        self.selectedGame = newValue
    }
    
    func getSelectedGame() -> Game {
        return self.selectedGame
    }
    
    func getGameList() {
        let url = URL(string: "https://api.igdb.com/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue("cvg9d0poxp7c42q8bxfbakkjz3okm7", forHTTPHeaderField: "Client-ID")
        requestHeader.setValue("Bearer xfz0mnu1o1eyid6ihx2ij2wqs8zkul", forHTTPHeaderField: "Authorization")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        requestHeader.httpBody = "fields: cover,genres,language_supports,name,platforms,rating,rating_count,screenshots,summary,url;".data(using: .utf8)
        
        URLSession.shared.dataTask(with: requestHeader) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let games = try decoder.decode([Game].self, from: data)
                    
                        Task {
                            var updatedGames = [Game]()
                            
                            for var game in games {
                                if let coverId = game.cover {
                                    do {
                                        if let cover = try await self.getCoverImage(id: coverId) {
                                            game.coverUrl = "https:\(cover.url ?? "//media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=")"
                                        }
                                    } catch {
                                        print("Failed to fetch cover for game: \(game.name ?? "Sem nome")")
                                    }
                                }
                                updatedGames.append(game)
                            }
                            
                            DispatchQueue.main.async {
                                self.gamesList = updatedGames
                            }
                        }
                } catch {
                    print("Error converting data to JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func getGameById(id: Int) {
        let url = URL(string: "https://api.igdb.com/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue("cvg9d0poxp7c42q8bxfbakkjz3okm7", forHTTPHeaderField: "Client-ID")
        requestHeader.setValue("Bearer xfz0mnu1o1eyid6ihx2ij2wqs8zkul", forHTTPHeaderField: "Authorization")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        requestHeader.httpBody = "fields: cover,genres,language_supports,name,platforms,rating,rating_count,screenshots,summary,url; where id = \(id);".data(using: .utf8)
        
        URLSession.shared.dataTask(with: requestHeader) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let games = try decoder.decode([Game].self, from: data)
                    
                        Task {
                            var updatedGames = [Game]()
                            
                            for var game in games {
                                if let coverId = game.cover {
                                    do {
                                        if let cover = try await self.getCoverImage(id: coverId) {
                                            game.coverUrl = "https:\(cover.url ?? "//media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=")"
                                        }
                                    } catch {
                                        print("Failed to fetch cover for game: \(game.name ?? "Sem nome")")
                                    }
                                }
                                updatedGames.append(game)
                            }
                            DispatchQueue.main.async {
                                self.gamesList.append(contentsOf: updatedGames)
                                self.gamesList = self.gamesList
                            }
                        }
                } catch {
                    print("Error converting data to JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func getCoverImage(id: Int) async throws -> Cover? {
        let url = URL(string: "https://api.igdb.com/v4/covers")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = "fields height,url,width; where id = \(id);".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue("cvg9d0poxp7c42q8bxfbakkjz3okm7", forHTTPHeaderField: "Client-ID")
        requestHeader.setValue("Bearer u4mjbf4bxeymm5wvbys982yryyhnuo", forHTTPHeaderField: "Authorization")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await URLSession.shared.data(for: requestHeader)
        
        let decoder = JSONDecoder()
        let cover = try decoder.decode([Cover].self, from: data)
        
        return cover.first
    }
    
    func searchGame(searchText: String) {
        self.gamesList = [Game]()
        
        if (searchText.isEmpty) {
            self.getGameList()
        }
        else {
            let url = URL(string: "https://api.igdb.com/v4/games")!
            var requestHeader = URLRequest.init(url: url)
            requestHeader.httpMethod = "POST"
            requestHeader.setValue("cvg9d0poxp7c42q8bxfbakkjz3okm7", forHTTPHeaderField: "Client-ID")
            requestHeader.setValue("Bearer xfz0mnu1o1eyid6ihx2ij2wqs8zkul", forHTTPHeaderField: "Authorization")
            requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            
            requestHeader.httpBody = "search \"\(searchText)\"; fields: id;".data(using: .utf8)
            
            URLSession.shared.dataTask(with: requestHeader) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let gamesId = try decoder.decode([Id].self, from: data)
                        
                            Task {
                                var updatedGames = [Game]()
                                self.gamesList = updatedGames
                                for gameId in gamesId {
                                        do {
                                            self.getGameById(id: gameId.id ?? 0)
                                        }
                                }
                                
                            }
                    } catch {
                        print("Error converting data to JSON at searchGame: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
    
    func getGenres() {
        let url = URL(string: "https://api.igdb.com/v4/genres")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = "fields name,url; limit 50;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue("cvg9d0poxp7c42q8bxfbakkjz3okm7", forHTTPHeaderField: "Client-ID")
        requestHeader.setValue("Bearer xfz0mnu1o1eyid6ihx2ij2wqs8zkul", forHTTPHeaderField: "Authorization")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: requestHeader) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let genres = try decoder.decode([Genre].self, from: data)
                    print("Genres: \(genres)")
                    Task {
                        self.genresList = genres
                    }
                } catch {
                    print("Error converting data to JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func getPlatforms() {
        let url = URL(string: "https://api.igdb.com/v4/platforms")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = "fields name; limit 100;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue("cvg9d0poxp7c42q8bxfbakkjz3okm7", forHTTPHeaderField: "Client-ID")
        requestHeader.setValue("Bearer xfz0mnu1o1eyid6ihx2ij2wqs8zkul", forHTTPHeaderField: "Authorization")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: requestHeader) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let platforms = try decoder.decode([Platform].self, from: data)
                    print("Platforms: \(platforms)")
                    Task {
                        self.platformsList = platforms
                    }
                } catch {
                    print("Error converting data to JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
