import Foundation

@dynamicMemberLookup
@dynamicCallable
public struct Processor {

    public let executablePath: String
    public let arguments: [String]
    
    public init(
        executablePath: String,
        arguments: [String] = []
    ) {
        self.executablePath = executablePath
        self.arguments = arguments
    }
    
    public subscript(dynamicMember member: String) -> Self {
        Processor(executablePath: executablePath, arguments: arguments + [member])
    }
    
    @discardableResult
    public func dynamicallyCall(withArguments args: [String]) throws -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: executablePath)
        process.arguments = arguments + args
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        try process.run()
        
        return try pipe.fileHandleForReading.readToEndAndTrim()
    }
}

