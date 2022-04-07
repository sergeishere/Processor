import Foundation

@dynamicMemberLookup
@dynamicCallable
protocol DynamicProcess {}
extension DynamicProcess where Self: Process {
    subscript(dynamicMember member: String) -> Self {
        arguments = (arguments ?? []) + [member]
        return self
    }
    func dynamicallyCall(withArguments args: [String]) throws -> String {
        let pipe = Pipe()
        arguments = (arguments ?? []) + args
        standardOutput = pipe
        try run()
        return try pipe.fileHandleForReading.readToEndAndTrim()
    }
}

extension Process: DynamicProcess {}
extension Process {
    convenience init(executablePath: String) {
        self.init()
        executableURL = URL(fileURLWithPath: executablePath)
    }
}

