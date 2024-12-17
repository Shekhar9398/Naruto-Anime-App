
import Foundation
struct TailBeastModel : Codable {
    let tailedBeasts: [TailedBeast]
    let currentPage, pageSize, total: Int

    enum CodingKeys: String, CodingKey {
        case tailedBeasts = "tailed-beasts"
        case currentPage, pageSize, total
    }
}

// MARK: - TailedBeast
struct TailedBeast: Codable{
    let id: Int
    let name: String
    let images: [String]
    let debut: Debut
    let family: Family
    let jutsu: [String]
    let natureType: [String]?
    let personal: Personal
    let uniqueTraits: [String]?
    let voiceActors: VoiceActors?
    let tools: [String]?
}

// MARK: - Debut
struct Debut: Codable {
    let manga, anime: String
    let novel: Novel
    let movie: Movie
    let game: String
    let ova: String?
    let appearsIn: AppearsIn
}

enum AppearsIn: String, Codable {
    case animeMangaNovelGameMovie = "Anime, Manga, Novel, Game, Movie"
}

enum Movie: String, Codable {
    case narutoTheMovieBloodPrison = "Naruto the Movie: Blood Prison"
    case narutoTheMovieNinjaClashInTheLandOfSnow = "Naruto the Movie: Ninja Clash in the Land of Snow"
    case theLastNarutoTheMovie = "The Last: Naruto the Movie"
}

enum Novel: String, Codable {
    case narutoInnocentHeartDemonicBlood = "Naruto: Innocent Heart, Demonic Blood"
    case theLastNarutoTheMovie = "The Last: Naruto the Movie"
}

// MARK: - Family
struct Family: Codable {
    let incarnationWithTheGodTree, depoweredForm, creator, sibling: String?

    enum CodingKeys: String, CodingKey {
        case incarnationWithTheGodTree = "incarnation with the god tree"
        case depoweredForm = "depowered form"
        case creator, sibling
    }
}

// MARK: - Personal
struct Personal: Codable {
    let status, kekkeiGenkai: String?
    let classification: Affiliation
    let jinchūriki: [String]
    let titles: [String]?
    let species: String?
    let affiliation: Affiliation?
}

enum Affiliation: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Affiliation.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Affiliation"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - VoiceActors
struct VoiceActors: Codable {
    let japanese: String
    let english: Affiliation
}
