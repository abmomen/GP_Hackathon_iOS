//
//  TrendingVideos.swift
//  App
//
//  Created by Sharetrip-iOS on 19/12/2020.
//

import Foundation

// MARK: - TrendingVideos
struct TrendingVideos: Codable {
    let page: Int
    let results: [Video]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Video: Codable {
    let video: Bool?
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    let voteCount: Int
    let adult: Bool?
    let backdropPath: String
    let title: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let posterPath: String
    let popularity: Double
    let mediaType: MediaType
    let firstAirDate, name, originalName: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case video
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
        case title
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
        case firstAirDate = "first_air_date"
        case name
        case originalName = "original_name"
        case originCountry = "origin_country"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}
