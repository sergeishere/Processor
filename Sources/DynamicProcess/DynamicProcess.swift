import Foundation

@dynamicMemberLookup
@dynamicCallable
public struct DynamicProcess {

    public let executablePath: String
    public let arguments: [String]
    
    internal init(
        executablePath: String,
        arguments: [String] = []
    ) {
        self.executablePath = executablePath
        self.arguments = arguments
    }
    
    subscript(dynamicMember member: String) -> Self {
        DynamicProcess(executablePath: executablePath, arguments: arguments + [member])
    }
    
    @discardableResult
    func dynamicallyCall(withArguments args: [String]) throws -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: executablePath)
        process.arguments = arguments + args
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        try process.run()
        
        return try pipe.fileHandleForReading.readToEndAndTrim()
    }
}

