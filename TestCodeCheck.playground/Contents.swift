//
//  TestPrint.swift
//  ttc_bdnTests
//
//  Created by Pasonatech on 2021/03/18.
//

import XCTest
@testable import ttc_bdn

class TestPrint: XCTestCase {
    let testData = ["!"," ﾞ","➊","、","龠", "﨑", "髙"]
    let predictResults = ["!"," ﾞ","■","、","龠","■","■"]
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func testAvoidForbiddenCharactersExclamationMark(){
        let result = Printer.avoidForbiddenCharacters(testData[0]) == predictResults[0]
        XCTAssertTrue(result)
    }
    func testAvoidForbiddenCharactersSemivocalic(){
        let result = Printer.avoidForbiddenCharacters(testData[1]) == predictResults[1]
        XCTAssertTrue(result)
    }
    func testAvoidForbiddenCharactersCircleOne(){
        let result = Printer.avoidForbiddenCharacters(testData[2]) == predictResults[2]
        XCTAssertTrue(result)
    }
    func testAvoidForbiddenCharactersComma(){
        let result = Printer.avoidForbiddenCharacters(testData[3]) == predictResults[3]
        XCTAssertTrue(result)
    }
    func testAvoidForbiddenCharactersChineseCharacters1(){
        let result = Printer.avoidForbiddenCharacters(testData[4]) == predictResults[4]
        XCTAssertTrue(result)
    }
    func testAvoidForbiddenCharactersChineseCharacters2(){
        let result = Printer.avoidForbiddenCharacters(testData[5]) == predictResults[5]
        XCTAssertTrue(result)
    }
    func testAvoidForbiddenCharactersChineseCharacters3(){
        let result = Printer.avoidForbiddenCharacters(testData[6]) == predictResults[6]
        XCTAssertTrue(result)
    }
}
