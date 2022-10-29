//
//  AnimeListPresenter.swift
//  #19 AnimeBook
//
//  Created by Владимир Рубис on 21.10.2022.
//

import Foundation

/// Протокол передачи UI-ивентов модуля AnimeList
protocol AnimeListPresentation {
    /// Массив загруженных моделей аниме
    var animeModels: [AnimeModel] { get }
    /// Get-запрос с параметрами
    func getAnime(with parameters: [ParamRequest])
    /// Произвели нажатие на item
    func tapAnime(_ anime: AnimeModel)
}

/// Слой презентации модуля AnimeList
final class AnimeListPresenter {
    weak var delegate: AnimeListPresenterDelegate?
    private let router: AnimeListRouting
    private let dataFetcher: DataFetcherService = DataFetcherService()
    private let modelAdapter: Adaptation
    
    private(set) var animeModels: [AnimeModel] = [] {
        didSet {
            delegate?.updateUI()
        }
    }
    
    init(router: AnimeListRouting,
         modelAdapter: Adaptation = AnimeCellAdapter()) {
        self.router = router
        self.modelAdapter = modelAdapter
    }
}

// MARK: - AnimeListPresentation
extension AnimeListPresenter: AnimeListPresentation {
    func tapAnime(_ anime: AnimeModel) {
        router.showDetail(anime: anime)
    }
    
    func getAnime(with parameters: [ParamRequest]) {
        dataFetcher.fetchAnime(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let anime):
                self?.modelAdapter.getModels(from: anime) { models in
                    self?.animeModels = models
                }
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
