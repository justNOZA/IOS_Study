//
//  TestBdnAchievement.swift
//  ttc_bdnTests
//
//  Created by pasonatech on 2021/03/17.
//

import XCTest
@testable import ttc_bdn

class TestBdnAchievement: XCTestCase {
    
    var model: BdnModel!
    
    override func setUp() {
        super.setUp()
        self.model = BdnModel()
        
        Utils.deleteAllData()
        Utils.setLogin()
        GRDB.dbClear()
        GRDB.dbGet()
    }
    
    // No.1
    func testGetBdnData() {
        let (result, _) = model.getBdnData(bdnNo: "B2011000001")
        let tData = getFormData("BdnAchievement")
        
        XCTAssertEqual(result.result, "success")
        let data = result.data!
        XCTAssertEqual(data.bdn_no, tData?.bdn_no)
        XCTAssertEqual(data.issued_date, tData?.issued_date)
        XCTAssertEqual(data.issued_company_name, tData?.issued_company_name)
        XCTAssertEqual(data.target_ship, tData?.target_ship)
        XCTAssertEqual(data.refueling_port, tData?.refueling_port)
        XCTAssertEqual(data.refueling_start, tData?.refueling_start)
        XCTAssertEqual(data.refueling_end, tData?.refueling_end)
        XCTAssertEqual(data.barge_ship, tData?.barge_ship)
        XCTAssertEqual(data.barge_ship2, tData?.barge_ship2)
        XCTAssertEqual(data.special_notes, tData?.special_notes)
        XCTAssertEqual(data.signature, tData?.signature)
        XCTAssertEqual(data.sig_timestamp, tData?.sig_timestamp)
        XCTAssertEqual(data.sig_lat, tData?.sig_lat)
        XCTAssertEqual(data.sig_lon, tData?.sig_lon)
        XCTAssertEqual(data.camera_img, tData?.camera_img)
        
        for (index, fuel) in data.bunkerOilList!.enumerated() {
            let tFuel = tData!.bunkerOilList[index]
            
            XCTAssertEqual(fuel.fuel_name, tFuel.fuel_name)
            XCTAssertEqual(fuel.fuel_maker, tFuel.fuel_maker)
            XCTAssertEqual(fuel.fuel_shipment, tFuel.fuel_shipment)
            XCTAssertEqual(fuel.fuel_amount, tFuel.fuel_amount)
            XCTAssertEqual(fuel.fuel_unit, tFuel.fuel_unit)
        }
        
        for (index, lube) in data.lubeList!.enumerated() {
            let tLube = tData!.lubeList[index]
            
            XCTAssertEqual(lube.lubricant_name, tLube.lubricant_name)
            XCTAssertEqual(lube.package_name, tLube.package_name)
            XCTAssertEqual(lube.convert_amount, tLube.convert_amount)
            XCTAssertEqual(lube.package_amount, tLube.package_amount)
            XCTAssertEqual(lube.package_unit, tLube.package_unit)
            XCTAssertEqual(lube.lubricant_amount, tLube.lubricant_amount)
            XCTAssertEqual(lube.lubricant_unit, tLube.lubricant_unit)
        }
        
        for (index, supply) in data.equipmentList!.enumerated() {
            let tSupply = tData!.equipmentList[index]
            
            XCTAssertEqual(supply.supply_name, tSupply.supply_name)
            XCTAssertEqual(supply.supply_amount, tSupply.supply_amount)
            XCTAssertEqual(supply.supply_unit, tSupply.supply_unit)
        }
        
    }
    
    // No.2
    func testGetBdnData400Error() {
        let (data, _) = model.getBdnData(bdnNo: "B2011000011")
        
        XCTAssertEqual(data.errorCode, 400)
        XCTAssertEqual(data.messages, ["パラメーターが不正です。再度検索してください。","パラメーターが不正です。再度検索してください。"])
    }
    
    // No.3
    func testGetBdnData401Error() {
        let (data, _) = model.getBdnData(bdnNo: "B2011000012")
        
        XCTAssertEqual(data.errorCode, 401)
        XCTAssertEqual(data.messages, ["認証エラー","認証エラー"])
    }
    
    // No.4
    func testGetBdnData403Error() {
        let (data, _) = model.getBdnData(bdnNo: "B2011000013")
        
        XCTAssertEqual(data.errorCode, 403)
        XCTAssertEqual(data.messages, ["権限エラー","権限エラー"])
    }
    
    // No.5
    func testGetBdnData404Error() {
        let (data, _) = model.getBdnData(bdnNo: "B2011000014")
        
        XCTAssertEqual(data.errorCode, 404)
        XCTAssertEqual(data.messages, ["条件に一致するデータがありませんでした。","条件に一致するデータがありませんでした。"])
    }
    
    // No.6
    func testGetBdnData500Error() {
        let (data, _) = model.getBdnData(bdnNo: "B2011000015")
        
        XCTAssertEqual(data.errorCode, 500)
        XCTAssertEqual(data.messages, ["複数のレコード","複数のレコード"])
    }
    
    private func getFormData(_ fileName: String) -> testBdndata? {
        guard let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else { return nil }
        guard let tdata = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(testBdndata.self, from: tdata)
    }
}
