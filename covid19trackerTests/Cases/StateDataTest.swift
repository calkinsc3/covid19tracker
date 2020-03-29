//
//  covid19trackerTests.swift
//  covid19trackerTests
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import XCTest
@testable import covid19tracker

class StateDataTests: XCTestCase {
    
    let jsonDecoder = JSONDecoder()
    
    var stateData: Data?
    
    override func setUpWithError() throws {

    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStateData() throws {
        
        self.stateData = self.getMockData(forResource: "StateMock")
        XCTAssertNotNil(self.stateData)
        
        //Decode State Data
        if let givenStateData = self.stateData {
            do {
                self.jsonDecoder.dateDecodingStrategy = .iso8601
                let stateModels = try self.jsonDecoder.decode(StateModels.self, from: givenStateData)
                XCTAssertTrue(stateModels.count == 56, "State count should be 56. Count is \(stateModels.count)")
                
                if let wisconsinNumbers = stateModels.filter ({$0.state == "WI"}).first {
                    XCTAssertTrue(wisconsinNumbers.positive == 989, "WI Positive Number should be 989")
                    XCTAssertTrue(wisconsinNumbers.negative == 15232, "WI Negative Number should be 15232")
                }
                
                
            } catch  {
                XCTFail("Failed to decode State data: \(error)")
            }
        }
        
    }
    
    //MARK:- Helper Functions
    private func createPath(forJSONFile: String) -> URL {
        
        let jsonURL = URL(
            fileURLWithPath: forJSONFile,
            relativeTo: FileManager.documentDirectoryURL?.appendingPathComponent("\(forJSONFile)")
        ).appendingPathExtension("json")
        
        print("json path for \(forJSONFile) = \(jsonURL.absoluteString)")
        
        return jsonURL
    }
    
    private func getMockData(forResource: String) -> Data? {
        
        //This is included in they myamfam target becasue it will be used the app.
        let currentBundle = Bundle(for: type(of: self))
        if let pathForRecommendationMock = currentBundle.url(forResource: forResource, withExtension: "json") {
            do {
                return try Data(contentsOf: pathForRecommendationMock)
            } catch {
                XCTFail("Unable to convert \(pathForRecommendationMock) to Data.")
                return nil
            }
        } else {
            XCTFail("Unable to load \(forResource).json.")
            return nil
        }
        
    }
    
    
    
}
