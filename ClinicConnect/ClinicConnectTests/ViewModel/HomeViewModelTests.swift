//
//  HomeViewModelTests.swift
//  ClinicConnectTests
//
//  Created by Macbook on 10/10/22.
//

import XCTest
@testable import ClinicConnect
class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel?
    
    override func setUp() {
        viewModel = HomeViewModel()
        let petsMock = PetsModelMock()
        viewModel?.petsModel = petsMock.getPetsMock()
        let settingModel = SettingModelMock()
        viewModel?.settingsModel = settingModel.getSettingMock()
        
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testWhetherwWrkHoursNil() {
        XCTAssertNotNil(viewModel?.settingsModel?.settings?.workHours)
    }
    
    func testCurrentTimeWithinWorkHours() {
        viewModel?.getOfficeHours { isAvailable in
            XCTAssertTrue(isAvailable)
        }
    }
    
    func testCurrentTimeOutsideWorkHours() {
        viewModel?.getOfficeHours { isAvailable in
            XCTAssertFalse(isAvailable)
        }
    }
    
    func testValidWorkHours() {
        XCTAssertTrue(viewModel?.validateOfficeHours() ?? true)
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
}
