import RegexBuilder 

struct Day03: AdventDay {
    let data: String

    func multiply(_ inputString: String) -> Int {
        let firstDigit = Reference(Int.self)
        let secondDigit = Reference(Int.self)

        let searchStr = Regex {
            "mul("
            TryCapture(as: firstDigit) {
                OneOrMore(.digit)
            } transform: { match in
                Int(match)
            }
            ","
            TryCapture(as: secondDigit) {
                OneOrMore(.digit)
            } transform: { match in 
                Int(match)
            }
            ")"
        }

        var total = 0
        let results = inputString.matches(of: searchStr)
        for result in results {
            total += result[firstDigit] * result[secondDigit]
        }

        return total
    }

    func stripData(_ inputStr: String) -> String {
        var output: [String] = []

        let substrs = data.split(separator: "do()")
        for substr in substrs {
            let tmpStr = String(substr.split(separator: "don't()")[0])
            output.append(tmpStr)
        }
        
        return output.joined()
    }

    func part1() -> Int {
        return multiply(data)
    }

    func part2() -> Int {
        let strippedData = stripData(data)
        return multiply(strippedData)
    }
}