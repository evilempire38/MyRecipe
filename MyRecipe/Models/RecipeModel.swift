

import Foundation

// MARK: - RecipeModel
struct RecipeModel: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable {
    let vegetarian, vegan : Bool
    let aggregateLikes, healthScore: Int
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String
    let image: String?
    let summary: String
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
    let preparationMinutes, cookingMinutes: Int?

    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, aggregateLikes, healthScore, extendedIngredients, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, summary, instructions, analyzedInstructions
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
    let measures: Measures
}

// MARK: - Measures
struct Measures: Codable {
    let metric: Metric
}
// MARK: - Metric
struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}



