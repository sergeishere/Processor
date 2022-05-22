import Foundation

@dynamicMemberLookup
@dynamicCallable
public struct Processor {

    public let executablePath: String
    public let arguments: [String]
    public let environment: [String: String]?
    
    public init(
        executablePath: String,
        arguments: [String] = [],
        environment: [String: String]? = nil
    ) {
        self.executablePath = executablePath
        self.arguments = arguments
        self.environment = environment
    }
    
    public func environment(_ environment: [String: String]) -> Self {
        Processor(executablePath: executablePath, arguments: arguments, environment: environment)
    }
    
    public subscript(dynamicMember member: String) -> Self {
        Processor(executablePath: executablePath, arguments: arguments + [member])
    }
    
    @discardableResult
    public func dynamicallyCall(
        withArguments args: [String]
    ) throws -> String {
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath: executablePath)
        process.arguments = arguments + args
        process.environment = environment
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        try process.run()
        
        return try pipe.fileHandleForReading.readToEndAndTrim()
    }
    
    
}

