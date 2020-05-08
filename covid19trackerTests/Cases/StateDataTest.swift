//
//  covid19trackerTests.swift
//  covid19trackerTests
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import XCTest
@testable import COVID_Tracker

class StateDataTests: XCTestCase {
    
    let jsonDecoder = JSONDecoder()
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStateData() throws {
        
        let stateData = self.getMockData(forResource: "StateMock")
        XCTAssertNotNil(stateData, "State mock did not load")
        
        //Decode State Data
        if let givenStateData = stateData {
            do {
                self.jsonDecoder.dateDecodingStrategy = .iso8601
                let stateModels = try self.jsonDecoder.decode(StateModels.self, from: givenStateData)
                XCTAssertTrue(stateModels.count == 56, "State count should be 56. Count is \(stateModels.count)")
                
                if let wisconsinNumbers = stateModels.filter ({$0.state == "WI"}).first {
                    XCTAssertTrue(wisconsinNumbers.positive == 9215, "WI Positive Number should be 9215")
                    XCTAssertTrue(wisconsinNumbers.negative == 93035, "WI Negative Number should be 93035")
                }
                
                
            } catch  {
                XCTFail("Failed to decode State data: \(error)")
            }
        }
        
    }
    
    func testStateDailyData() throws {
        
        let stateDailyData = self.getMockData(forResource: "StateDaily")
        XCTAssertNotNil(stateDailyData, "State Daily mock did not load")
        
        //Decode State Data
        if let givenStateData = stateDailyData {
            do {
                self.jsonDecoder.dateDecodingStrategy = .iso8601
                let stateDailyData = try self.jsonDecoder.decode(StateDailyData.self, from: givenStateData)
                XCTAssertTrue(stateDailyData.count == 38, "State count should be 27. Count is \(stateDailyData.count)")
                
                if let nyNumbers = stateDailyData.first {
                    XCTAssertTrue(nyNumbers.positive == 170512, "WI Positive Number should be 92381")
                    XCTAssertTrue(nyNumbers.negative == 247373, "WI Negative Number should be 146584")
                }
                
                
            } catch  {
                XCTFail("Failed to decode State data: \(error)")
            }
        }
        
    }
    
    
    func testStateInfo() throws {
        
        let stateInfoData = self.getMockData(forResource: "StateInfo")
        XCTAssertNotNil(stateInfoData, "State Info mock did not load")
        
        //Decode State Info Data
        if let givenStateInfoData = stateInfoData {
            do {
                
                let stateInfoModel = try self.jsonDecoder.decode(StateInfo.self, from: givenStateInfoData)
                XCTAssertTrue(stateInfoModel.count == 56, "State info count should be 50. Count is \(stateInfoModel.count)")
                
                if let akStateInfo = stateInfoModel.first {
                    XCTAssertTrue(akStateInfo.kind == "url", "akStateInfo.kind should be url")
                    XCTAssertTrue(akStateInfo.name == "Alaska", "akStateInfo.name should be Alaska")
                    XCTAssertTrue(akStateInfo.stateId == "AK", "akStateInfo.stateId should be AK")
                }
                
                
            } catch  {
                XCTFail("Failed to decode State Info data: \(error)")
            }
        }
        
    }
    
    func testPressInfo() throws {
        
        let statePressData = self.getMockData(forResource: "PressInfo")
        
        //Decode State Press Data
        if let givenPressInfoData = statePressData {
            do {
                let statePressInfo = try self.jsonDecoder.decode(PressData.self, from: givenPressInfoData)
                XCTAssertTrue(statePressInfo.count == 60, "State Press count should be 100. Count is \(statePressInfo.count)")
                
            } catch {
                XCTFail("Failed to decode Press info data: \(error)")
            }
            
        }
    }
    
    func testUSTotals() throws {
        
        let usInfo  = self.getMockData(forResource: "USTotals")
        
        //Decode State Press Data
        if let giveUSInfo = usInfo {
            do {
                let usTotals = try self.jsonDecoder.decode(USTotals.self, from: giveUSInfo)
                if let givenTotalInfo = usTotals.first {
                    XCTAssertTrue(givenTotalInfo.positive == 307913, "givenTotalInfo.positive should be 307913" )
                    XCTAssertTrue(givenTotalInfo.death == 8381, "givenTotalInfo.death should be 8381")
                    XCTAssertTrue(givenTotalInfo.hospitalized == 38615, "givenTotalInfo.death should be 38615" )
                    XCTAssertTrue(givenTotalInfo.recovered == 12787, "givenTotalInfo.death should be 12787" )
                }
            } catch {
                XCTFail("Failed to decode Press info data: \(error)")
                
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
