import XCTest
@testable import DynamicProcess

final class DynamicProcessTests: XCTestCase {
    
    func testStandardRun() throws {
        let pwd = Process(executablePath: "/bin/pwd")
        XCTAssertNoThrow(try pwd.run())
    }
    
    func testDynamicCall() throws {
        let pwd = Process(executablePath: "/bin/pwd")
        let result = try pwd()
        XCTAssertFalse(result.isEmpty)
    }
    
    func testDynamicMember() throws {
        let swift = Process(executablePath: "/usr/bin/swift")
        let result = try swift.help.package()
        print(result)
        XCTAssertFalse(result.isEmpty)
    }
    
    func testDynamicMemberAndDynamicCall() throws {
        let swift = Process(executablePath: "/usr/bin/swift")
        let result = try swift.help.package("-h")
        print(result)
        XCTAssertFalse(result.isEmpty)
    }
    
}
