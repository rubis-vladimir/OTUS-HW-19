//
//  DataFetcherService.swift
//  #19 AnimeBook
//
//  Created by Владимир Рубис on 24.10.2022.
//

import Foundation

/// Ошибки загрузки данных
enum DataFetcherError: Error {
    case notUrl
    case failedToLoad
    case failedToDecode
    case imageFailedToLoad
}

// MARK: Сервис получения данных
final class DataFetcherService {
    
    var dataFetcher: DataFetcherProtocol
    
    init(dataFetcher: DataFetcherProtocol = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    /// Возвращает массив данных разработчиков, декодированный
    /// из локально расположенного файла JSON
    func fetchAnime(parameters: [ParamRequest],
                    completion: @escaping (Result<Anime, DataFetcherError>) -> Void) {
        let defaultUrl = "https://api.jikan.moe/v4/anime"
        let fullUrl = defaultUrl + getParametersString(from: parameters)
        print(fullUrl)
        dataFetcher.fetchJSONData(from: fullUrl, completion: completion)
    }
    
    /// Получает строку параметров для запроса
    ///  - Parameter parameters: массив параметров
    private func getParametersString(from parameters: [ParamRequest]) -> String {
        guard !parameters.isEmpty else { return "" }
        
        let parametersString = parameters.reduce(into: "?") {
            var paramString = ""
            
            switch $1 {
            case .limit(let value):
                paramString = "limit=" + String(value) + "&"
            case .letter(let value):
                paramString = "letter=" + value + "&"
            case .startDate(let value):
                paramString = "start_date=" + value.convertDateToString() + "&"
            case .endDate(let value):
                paramString = "end_date=" + value.convertDateToString() + "&"
            }
            
            $0 += paramString
        }
        return String(parametersString.dropLast())
    }
}
