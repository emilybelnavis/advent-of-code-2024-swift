import Algorithms

struct Day02: AdventDay {
    var data: String

    var entities: [[Int]] {
        let trimmedData = data.trimmingCharacters(in: .newlines)
        
        return trimmedData.components(separatedBy: "\n").map {
            $0.components(separatedBy: " ").compactMap(Int.init)
        }
    }

    func resolve(_ report: [Int]) -> Bool {

        var idx = 0
        while(idx < report.count) {
            var dampenedReport = report
            dampenedReport.remove(at: idx)
            if safetyCheck(dampenedReport) { return true }
            idx+=1
        }
        return false
    }

    func safetyCheck(_ report: [Int], dampened: Bool = false) -> Bool {
        guard report[0] != report[1], abs(report[0] - report[1]) <= 3 else {
            if dampened {
                return resolve(report)
            }
            return false
        }
        let initialDirection = (report[1] - report[0]) / abs(report[1] - report[0])
        for idx in 1..<report.count {
            guard report[idx] != report[idx - 1], abs(report[idx] - report[idx - 1]) <= 3 else {
                if dampened { 
                    return resolve(report)
                }
                return false
            }
            let currentDirection = (report[idx] - report[idx - 1]) / abs(report[idx] - report[idx - 1])
            guard initialDirection / currentDirection == 1 else {
                if dampened {
                    return resolve(report)
                }
                return false
            }
        }

        return true
    }

    func part1() async throws -> Int {
        entities.filter{safetyCheck($0)}.count
    }

    func part2() async throws -> Int {
        entities.filter{safetyCheck($0, dampened: true)}.count
    }
}