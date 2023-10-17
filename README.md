# TutorialPreviewWithMockData
This sample tutorial app highlights Xcode preview integration with mock data. Introduced a simple mockable protocol that can be adopted by any struct or class, allowing you to create mockable objects. Mock JSON data is stored in developer assets, ensuring minimal impact on app size and making it accessible exclusively in the debug configuration.

# Incorporate all UI behavior within the preview.

https://github.com/SarathVSasikala/TutorialPreviewWithMockData/assets/146827282/6a90ab53-43ce-4366-afbc-28b7ab3d9f29

# How to Implement the Preview Protocol
1. Integrate a basic 'Mockable' protocol within the 'Preview Content' folder ('Developer assets' folder, as it's specifically required during development and debugging configurations).
```swift
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
```
2. Add mock response JSON files.
3. Extend your class and confirm the Mockable protocol
Example:
``` swift
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
```
4. Simply update your preview class with these responses.
``` swift
#Preview("Success Profile") {
    UserProfileView(user: User.mock(.success)!)
}

#Preview("Required Fields Profile") {
    UserProfileView(user: User.mock(.requiredFields)!)
}

#Preview("Student Profile") {
    UserProfileView(user: User.mock(.student)!)
}
```
# Summary
Utilizing the Mockable protocol provides a straightforward method for simulating JSON responses and UI behaviour. This allows us to address various API response UI scenarios directly within the previews.
