
import Foundation
struct Character: Codable {
    let id: Int
    let name: String
    let images: [String]
    let debut: Debut
    let family: Family?
    let jutsu: [String]
    let natureType: [String]?
    let personal: Personal
    let rank: Rank?
    let tools: [String]?
    let voiceActors: VoiceActors
    let uniqueTraits: [String]?
}

// MARK: - Debut
struct Debut: Codable {
    let manga, anime: String
    let novel, movie: String?
    let game: String
    let ova: String?
    let appearsIn: AppearsIn
}

enum AppearsIn: String, Codable {
    case animeMangaGame = "Anime, Manga, Game"
    case animeMangaGameMovie = "Anime, Manga, Game, Movie"
    case animeMangaNovelGameMovie = "Anime, Manga, Novel, Game, Movie"
}

// MARK: - Family
struct Family: Codable {
    let father, mother, son, daughter: String?
    let wife, adoptiveSon, godfather, brother: String?
    let cloneSon, familyGrandmother, sister, nephew: String?
    let uncle, adoptiveMother, adoptiveSons, adoptiveBrother: String?
    let clone, godson, greatGrandfather, grandfather: String?
    let grandmother, cousin, geneticTemplateParent, cloneBrother: String?
    let pet, grandson, granddaughter, granduncle: String?
    let aunt, firstCousinOnceRemoved, host, niece: String?
    let lover, creator, geneticTemplate: String?

    enum CodingKeys: String, CodingKey {
        case father, mother, son, daughter, wife
        case adoptiveSon = "adoptive son"
        case godfather, brother
        case cloneSon = "clone/son"
        case familyGrandmother = "grandmother "
        case sister, nephew, uncle
        case adoptiveMother = "adoptive mother"
        case adoptiveSons = "adoptive sons"
        case adoptiveBrother = "adoptive brother"
        case clone, godson
        case greatGrandfather = "great-grandfather"
        case grandfather, grandmother, cousin
        case geneticTemplateParent = "genetic template/parent"
        case cloneBrother = "clone/brother"
        case pet = "pet "
        case grandson, granddaughter, granduncle, aunt
        case firstCousinOnceRemoved = "first cousin once removed"
        case host, niece, lover, creator
        case geneticTemplate = "genetic template"
    }
}

// MARK: - Personal
struct Personal: Codable {
    let birthdate: String?
    let sex: Sex
    let age: Age?
    let height: Height?
    let weight: Weight?
    let bloodType: BloodType?
    let kekkeiGenkai, classification: Clan?
    let tailedBeast: String?
    let occupation: Clan?
    let affiliation: [String]
    let team, clan: Clan?
    let titles: [String]?
    let status, kekkeiMōra: String?
    let partner: Clan?
    let species: String?
}

// MARK: - Age
struct Age: Codable {
    let partI, partII, academyGraduate, chuninPromotion: String?
    let blankPeriod, borutoMovie, borutoManga: String?

    enum CodingKeys: String, CodingKey {
        case partI = "Part I"
        case partII = "Part II"
        case academyGraduate = "Academy Graduate"
        case chuninPromotion = "Chunin Promotion"
        case blankPeriod = "Blank Period"
        case borutoMovie = "Boruto Movie"
        case borutoManga = "Boruto Manga"
    }
}

enum BloodType: String, Codable {
    case a = "A"
    case ab = "AB"
    case b = "B"
    case o = "O"
}

enum Clan: Codable {
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
        throw DecodingError.typeMismatch(Clan.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Clan"))
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

// MARK: - Height
struct Height: Codable {
    let partI, partII, blankPeriod, gaiden: String?
    let borutoMovie, borutoManga: String?

    enum CodingKeys: String, CodingKey {
        case partI = "Part I"
        case partII = "Part II"
        case blankPeriod = "Blank Period"
        case gaiden = "Gaiden"
        case borutoMovie = "Boruto Movie"
        case borutoManga = "Boruto Manga"
    }
}

enum Sex: String, Codable {
    case female = "Female"
    case fileGenderVariousSVGVarious = "File:Gender Various.svg Various"
    case male = "Male"
}

// MARK: - Weight
struct Weight: Codable {
    let partI, partII: String?

    enum CodingKeys: String, CodingKey {
        case partI = "Part I"
        case partII = "Part II"
    }
}

// MARK: - Rank
struct Rank: Codable {
    let ninjaRank: NinjaRank
    let ninjaRegistration: String?
}

// MARK: - NinjaRank
struct NinjaRank: Codable {
    let partI, gaiden, blankPeriod, partII: String?

    enum CodingKeys: String, CodingKey {
        case partI = "Part I"
        case gaiden = "Gaiden"
        case blankPeriod = "Blank Period"
        case partII = "Part II"
    }
}

// MARK: - VoiceActors
struct VoiceActors: Codable {
    let japanese, english: Clan
}
