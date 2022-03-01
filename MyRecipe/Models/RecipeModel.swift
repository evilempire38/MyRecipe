

import Foundation

// MARK: - RecipeModel
struct RecipeModel: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable {
    let vegetarian : Bool
    let healthScore: Int
    var extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String?
    let summary: String
    let analyzedInstructions: [AnalyzedInstruction]

    enum CodingKeys: String, CodingKey {
        case vegetarian, healthScore, extendedIngredients, id, title, readyInMinutes
        case image, summary, analyzedInstructions
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

}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable {
    let id: Int?
    let aisle, image: String?
    let name: String
    let nameClean: String?
    let original, originalName: String
    let amount: Double
    let unit: String
    var measures: Measures
}

// MARK: - Measures
struct Measures: Codable {
    var metric: Metric
}
// MARK: - Metric
struct Metric: Codable {
    var amount: Double
    var unitShort, unitLong: String
}



