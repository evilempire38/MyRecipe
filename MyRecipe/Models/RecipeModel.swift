// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeModel = try? newJSONDecoder().decode(RecipeModel.self, from: jsonData)

import Foundation

// MARK: - RecipeModel
struct RecipeModel: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let weightWatcherSmartPoints: Int
    let gaps: Gaps
    let lowFodmap: Bool
    let aggregateLikes, spoonacularScore, healthScore: Int
    let sourceName: SourceName
    let pricePerServing: Double
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String
    let image: String
    let imageType: ImageType
    let summary: String
    let cuisines, dishTypes, diets, occasions: [String]
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
    let originalID: JSONNull?
    let spoonacularSourceURL: String
    let preparationMinutes, cookingMinutes: Int?

    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, weightWatcherSmartPoints, gaps, lowFodmap, aggregateLikes, spoonacularScore, healthScore, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, imageType, summary, cuisines, dishTypes, diets, occasions, instructions, analyzedInstructions
        case originalID = "originalId"
        case spoonacularSourceURL = "spoonacularSourceUrl"
        case preparationMinutes, cookingMinutes
    }
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}

// MARK: - Step
struct Step: Codable {
    let number: Int
    let step: String
    let ingredients, equipment: [Ent]
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable {
    let id: Int
    let name, localizedName, image: String
    let temperature: Length?
}

// MARK: - Length
struct Length: Codable {
    let number: Int
    let unit: Unit
}

enum Unit: String, Codable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case minutes = "minutes"
}


// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable {
    let id: Int?
    let aisle, image: String?
    let consistency: Consistency?
    let name: String
    let nameClean: String?
    let original, originalString, originalName: String
    let amount: Double
    let unit: String
    let meta, metaInformation: [String]
    let measures: Measures
}

enum Consistency: String, Codable {
    case liquid = "liquid"
    case solid = "solid"
}

// MARK: - Measures
struct Measures: Codable {
    let us, metric: Metric
}

// MARK: - Metric
struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}

enum Gaps: String, Codable {
    case no = "no"
}

enum ImageType: String, Codable {
    case jpg = "jpg"
    case png = "png"
}


enum SourceName: String, Codable {
    case foodAndSpice = "Food and Spice"
    case foodista = "Foodista"
    case pinkWhen = "Pink When"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
