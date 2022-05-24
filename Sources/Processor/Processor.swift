import Foundation

@dynamicMemberLookup
@dynamicCallable
public struct Processor {

    public let executablePath: String
    public let arguments: [String]
    public let environment: [String: String]?
    
    public struct ProcessError: Error, CustomStringConvertible {
        public var description: String
    }
    
    public init(
        executablePath: String,
        arguments: [String] = [],
        environment: [String: String]? = ProcessInfo.processInfo.environment
    ) {
        self.executablePath = executablePath
        self.arguments = arguments
        self.environment = environment
    }
    
    public subscript(dynamicMember member: String) -> Self {
        Processor(executablePath: executablePath, arguments: arguments + [member], environment: environment)
    }
    
    @discardableResult
    public func run(arguments: [String] = []) throws -> String {
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath: executablePath)
        process.arguments = self.arguments + arguments
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.environment = environment
        
        try process.run()
        
        return try pipe.fileHandleForReading.readToEndAndTrim()
        
    }
    
    @discardableResult
    public func dynamicallyCall(
        withArguments args: [String]
    ) throws -> String {
        return try run(arguments: args)
    }
    
    
}

