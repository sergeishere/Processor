import Foundation

extension FileHandle {

    func readToEndAndTrim() throws -> String {
        let data: Data
        if #available(macOS 10.15.4, *) {
            data = try readToEnd() ?? Data()
        } else {
            data = readDataToEndOfFile()
        }
        return String(decoding: data, as: UTF8.self)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
