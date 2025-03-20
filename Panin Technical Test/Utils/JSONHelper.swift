//
//  JSONHelper.swift
//  Technical Test
//
//  Created by Bryan Vernanda on 16/03/25.
//

import Foundation

class JSONHelper {
    static let templateName: String = "SampleData"

    public static func readJSONFromFile<T: Decodable>(fileName: String,
                                                      type: T.Type,
                                                      bundle: Bundle? = nil) async throws -> T {
        // Get the bundle URL for the file
        guard let url = (bundle ?? Bundle.main).url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "JSONUtils", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            throw NSError(domain: "JSONUtils", code: 500, userInfo: [NSLocalizedDescriptionKey: "Decoding error: \(error)"])
        }
    }
}
