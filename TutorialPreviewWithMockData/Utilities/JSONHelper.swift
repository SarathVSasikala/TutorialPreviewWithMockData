//
//  JSONHelper.swift
//  TutorialMockData
//
//  Created by Sarath Sasikala on 12/10/2023.
//

import Foundation

func readJSONStringFromFile(named fileName: String) -> String? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let jsonString = try String(contentsOfFile: path, encoding: .utf8)
            return jsonString
        } catch {
            print("Error reading JSON file: \(error)")
            return nil
        }
    } else {
        print("JSON file not found.")
        return nil
    }
}

extension String {
    func decodeJSON<T: Decodable>(as type: T.Type) -> T? {
        if let jsonData = data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(type, from: jsonData)
                return decodedObject
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return nil
    }
}
