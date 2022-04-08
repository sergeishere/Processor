import XCTest
@testable import DynamicProcess

final class DynamicProcessTests: XCTestCase {
    
    func testStandardRun() throws {
        let pwd = DynamicProcess(executablePath: "/bin/pwd")
        XCTAssertNoThrow(try pwd.run())
    }
    
    func testDynamicCall() throws {
        let pwd = DynamicProcess(executablePath: "/bin/pwd")
        let result = try pwd()
        XCTAssertFalse(result.isEmpty)
    }
    
    func testDynamicMember() throws {
        let swift = DynamicProcess(executablePath: "/usr/bin/swift")
        let result = try swift.help.package()
        XCTAssertFalse(result.isEmpty)
    }
    
    func testDynamicMemberAndDynamicCall() throws {
        let swift = DynamicProcess(executablePath: "/usr/bin/swift")
        let result = try swift.help.package("-h")
        XCTAssertFalse(result.isEmpty)
    }
    
    func testOneProcessSeveralCommands() throws {
        let touch = DynamicProcess(executablePath: "/usr/bin/touch")
        try touch("File1")
        try touch("File2")
        
        let file = DynamicProcess(executablePath: "/usr/bin/file")
        let firstFileInfo = try file("File1")   // File1: empty
        let secondFileInfo = try file("File2")  // File2: empty
        XCTAssertNotEqual(firstFileInfo, secondFileInfo)
    }
    
}
