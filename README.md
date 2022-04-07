# DynamicProcess

Convenient extensions to the Swift Foundation's Process class powered by `@dynamicMemberLookup` and `@dynamicCallable` attributes.

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
