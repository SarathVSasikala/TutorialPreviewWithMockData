//
//  User+Mocks.swift
//  TutorialPreviewWithMockData
//
//  Created by Sarath Sasikala on 16/10/2023.
//

import Foundation

// IMPORTANT: Xcode Development assets are not accessible in the release configuration.
// To prevent the inclusion of development assets in release code, follow this check.
#if DEBUG

/// An extension of the `User` model that provides mock data for Preview/testing purposes.
/// NOTE: This extension is only accessible in the DEBUG configuration.
extension User: Mockable {
    // Define the associated type for mock responses.
    typealias mockResponseTypes = userMock
    
    /// Enumeration of available mock responses for the `User` model.
    enum userMock: JSONFileMockable {
        case success
        case requiredFields
        case student
        
        /// Returns the name of the associated JSON file for each mock response.
        func JSONfileName() -> String {
            switch self {
            case .success: "UserSuccessMockResponse"
            case .requiredFields: "RequiredFieldsMockResponse"
            case .student: "StudentMockResponse"
            }
        }
    }
}
#endif
