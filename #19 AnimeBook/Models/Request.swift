//
//  Request.swift
//  #19 AnimeBook
//
//  Created by Владимир Рубис on 25.10.2022.
//

import Foundation

/// Варианты параметров
enum ParamRequest {
    case limit(_ value: Int)
    case letter(_ value: String)
    case startDate(_ value: Date)
    case endDate(_ value: Date)
}
