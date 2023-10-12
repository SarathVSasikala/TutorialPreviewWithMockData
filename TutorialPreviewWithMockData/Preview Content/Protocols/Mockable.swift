//
//  Mockable.swift
//  TutorialMockData
//
//  Created by Sarath Sasikala on 11/10/2023.
//

import Foundation

/// A marker protocol representing mock responses.
protocol MockResponseRepresentable: CaseIterable {}

/// A protocol for creating mockable objects that can return mock responses.
protocol Mockable {
    associatedtype mockResponseTypes: MockResponseRepresentable
    
    /// Returns a mock data string for a given mock response type.
    ///
    /// - Parameter mockType: The type of mock response to retrieve.
    /// - Returns: A mock data string, if available; otherwise, `nil`.
    static func getMock(of mockType: mockResponseTypes) -> String?
    
    /// Creates a mock object of the conforming type with mock data.
    ///
    /// - Parameter mockType: The type of mock response to use.
    /// - Returns: An instance of the conforming type with mock data, or `nil` if the data is invalid.
    static func mock(_ mockType: mockResponseTypes) -> Self?
}

extension Mockable {
    /// Creates a mock object of the conforming type with mock data.
    ///
    /// - Parameter mockType: The type of mock response to use.
    /// - Returns: An instance of the conforming type with mock data, or `nil` if the data is invalid.
    static func mock(_ mockType: mockResponseTypes) -> Self? where Self: Decodable {
        if let mockJSONString = self.getMock(of: mockType) {
            return mockJSONString.decodeJSON(as: Self.self)
        }
        return nil
    }
}

/// An extension of the `Mockable` protocol to handle JSON file-based mock responses.
extension Mockable where mockResponseTypes: JSONFileMockable {
    /// Retrieves a mock data string for a specific JSON file-based mock response.
    ///
    /// - Parameter mockType: The type of JSON file-based mock response for which mock data is requested.
    /// - Returns: A string containing the mock data from the specified JSON file, if available; otherwise, `nil`.
    /// - Note: The `mockType` argument is expected to conform to the `JSONFileMockable` protocol and provide the name of the associated JSON file through the `JSONFileName` method.
    ///
    /// This extension enables easy retrieval of mock data from JSON files for conforming types when working with JSON-based mock responses.
    /// If the specified JSON file does not exist or cannot be read, the function returns `nil`.
    static func getMock(of mockType: mockResponseTypes) -> String?  {
        readJSONStringFromFile(named: mockType.JSONfileName())
    }
}

/// A protocol for objects that use JSON file-based mock responses.
protocol JSONFileMockable: MockResponseRepresentable {
    /// Returns the name of the JSON file associated with this mock response type.
    ///
    /// - Returns: The name of the JSON file associated with mock response type.
    func JSONfileName() -> String
}

/// A protocol for objects that use JSON string-based mock responses.
protocol JSONStringMockable: MockResponseRepresentable {}




