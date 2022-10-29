//
//  NetworkDataFetcher.swift
//  #19 AnimeBook
//
//  Created by Владимир Рубис on 24.10.2022.
//

import Foundation

// MARK: Протокол получения данных
protocol DataFetcherProtocol {
    
    /// Получает данные из объекта JSON и декодировует их
    ///  - Parameters:
    ///     - from: путь к файлу с данными / url
    ///     - responce: замыкание для захвата данных/ошибки
    func fetchJSONData<T:Decodable>(from: String,
                                    completion: @escaping (Result<T, DataFetcherError>) -> Void)
}

// MARK: Класс для получения и декодировки данных из сети
final class NetworkDataFetcher: DataFetcherProtocol {
    
    /// Запрашивает данные из сети и при получении декодирует в модель типа `T`
    func fetchJSONData<T: Decodable>(from urlString: String,
                                     completion: @escaping (Result<T, DataFetcherError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.notUrl))
            return
        }
        
        /// Get-запрос
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {
                completion(.failure(.failedToLoad))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.failedToDecode))
            }
        }.resume()
    }
}

