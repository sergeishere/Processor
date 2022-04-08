import XCTest
@testable import Processor

final class ProcessorTests: XCTestCase {
    
    func testStandardRun() throws {
        let pwd = Processor(executablePath: "/bin/pwd")
        XCTAssertNoThrow(try pwd.run())
    }
    
    func testDynamicCall() throws {
        let pwd = Processor(executablePath: "/bin/pwd")
        let result = try pwd()
        XCTAssertFalse(result.isEmpty)
    }
    
    func testDynamicMember() throws {
        let swift = Processor(executablePath: "/usr/bin/swift")
        let result = try swift.help.package()
        XCTAssertFalse(result.isEmpty)
    }
    
    func testDynamicMemberAndDynamicCall() throws {
        let swift = Processor(executablePath: "/usr/bin/swift")
        let result = try swift.help.package("-h")
        XCTAssertFalse(result.isEmpty)
    }
    
    func testOneProcessSeveralCommands() throws {
        let touch = Processor(executablePath: "/usr/bin/touch")
        let file = Processor(executablePath: "/usr/bin/file")
        let rm = Processor(executablePath: "/bin/rm")
        
        try touch("File1")
        try touch("File2")
        
        let firstFileInfo = try file("File1")   // File1: empty
        let secondFileInfo = try file("File2")  // File2: empty
        
        XCTAssertNotEqual(firstFileInfo, secondFileInfo)
        
        try rm("File1")
        try rm("File2")
        
    }
    
}
