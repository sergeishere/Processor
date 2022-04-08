# Processor

Processor is a simple swift package powered by `@dynamicMemberLookup` and `@dynamicCallable` attributes which makes it easier to work with a Process class from a swift code.

``` swift
// Before

let process = Process()
let pipe = Pipe()

process.executableURL = URL(fileURLWithPath: "/usr/bin/file")
process.arguments = ["Processor.swift"]
process.standardOutput = pipe

try process.run()

if let outputData = try pipe.fileHandleForReading.readToEnd() {
  let outputString = String(decoding: outputData, as: UTF8.self)
  let trimmedOutput = outputString.trimmingCharacters(in: .whitespacesAndNewlines)
  print(trimmedOutput) // "Processor.swift: ASCII text"
}

// After

let file = Processor(executablePath: "/usr/bin/file")
let fileInfo = try file("Processor.swift")
print(fileInfo) // "Processor.swift: ASCII text"
```

# Usage

Examples of usage of some shell commands:

``` swift
// pwd
let pwd = Processor(executablePath: "/bin/pwd")
let currentDir = try pwd()

// ls -la
let ls = Processor(executablePath: "/bin/ls")
let filesList = try ls("-la")

// swift help
let swift = Processor(executablePath: "/usr/bin/swift")
let help = try swift.help()

// CURRENT_BRANCH=$(git branch --show-current)
// git rev-list --count $CURRENT_BRANCH
let git = Processor(executablePath: "/usr/bin/git")
let currentBranch = try git.branch("--show-current")
let commitsCount = try git("rev-list", "--count", currentBranch)
```
