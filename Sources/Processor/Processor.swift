import Foundation

@dynamicMemberLookup
@dynamicCallable
public struct Processor {

    public let executablePath: String
    public let arguments: [String]
    public let environment: [String: String]?
    
    public struct ProcessError: Error, CustomStringConvertible {
        public let processName: String
        public let terminationStatus: Int32
        public let errorOutput: String?
        public let standardOutput: String?
        
        public var description: String {
            [
                "Process \(processName) ended with termination status: \(terminationStatus).",
                "Error output:", errorOutput,
                "Standard output:", standardOutput
            ]
                .compactMap { $0 }
                .joined(separator: "\n")
        }
    }
    
    public init(
        executablePath: String,
        arguments: [String] = [],
        environment: [String: String]? = nil
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
        let executableURL = URL(fileURLWithPath: executablePath)
        process.executableURL = executableURL
        process.arguments = self.arguments + arguments
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        let errorPipe = Pipe()
        process.standardError = errorPipe
        
        environment.map { process.environment = $0 }
        
        try process.run()
        process.waitUntilExit()
        
        guard process.terminationStatus == 0
        else {
            throw ProcessError(
                processName: executableURL.lastPathComponent,
                terminationStatus: process.terminationStatus,
                errorOutput: try? errorPipe.fileHandleForReading.readToEndAndTrim(),
                standardOutput: try? pipe.fileHandleForReading.readToEndAndTrim()
            )
        }
        print(process.terminationStatus, process.terminationReason)
        
        return try pipe.fileHandleForReading.readToEndAndTrim()
        
    }
    
    @discardableResult
    public func dynamicallyCall(
        withArguments args: [String]
    ) throws -> String {
        return try run(arguments: args)
    }
    
    
}

