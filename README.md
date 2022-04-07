# DynamicProcess

DynamicProcess is a simple and convenient extension to the Swift Foundation's Process class powered by `@dynamicMemberLookup` and `@dynamicCallable` attributes.

``` swift
// Before

let process = Process()
let pipe = Pipe()

process.executableURL = URL(fileURLWithPath: "/usr/bin/file")
process.arguments = ["DynamicProcess.swift"]
process.standardOutput = pipe

try process.run()

if let outputData = try pipe.fileHandleForReading.readToEnd() {
  let outputString = String(decoding: outputData, as: UTF8.self)
  let trimmedOutput = outputString.trimmingCharacters(in: .whitespacesAndNewlines)
  print(trimmedOutput) // "DynamicProcess.swift: ASCII text"
}

// After

let file = Process(executablePath: "/usr/bin/file")
let fileInfo = try file("DynamicProcess.swift")
print(fileInfo) // "DynamicProcess.swift: ASCII text"

```

# Usage

Examples of using some shell commands:

- Pwd: `pwd`

  ``` swift
  let pwd = Process(executablePath: "/bin/pwd")
  let currentDir = try pwd()
  ```

- Ls: `ls -la`

  ``` swift
  let ls = Process(executablePath: "/bin/ls")
  let filesList = try ls("-la")
  ```

- Swift: `swift help`

  ``` swift
  let swift = Process(executablePath: "/usr/bin/swift")
  let help = try swift.help()
  ```
  
- Git: `git rev-list --count main`

  ``` swift
  let git = Process(executablePath: "/usr/bin/git")
  let currentBranch = try git.branch("--show-current")
  let commitsCount = try git("rev-list", "--count", currentBranch)
  ```
