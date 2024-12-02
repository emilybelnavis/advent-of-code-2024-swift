import Algorithms

struct Day01: AdventDay {

  var data: String
  var entities: [[Int]] {
    let listParts = data.components(separatedBy: "\n")
    var leftList = [Int?]()
    var rightList = [Int?]()

    listParts.forEach {
      let values = $0.components(separatedBy: "   ")
      guard values.count == 2 else { return }
      leftList.append(Int(values[0]))
      rightList.append(Int(values[1]))
    }
    return [leftList.compactMap { $0 }, rightList.compactMap { $0 }]

  }

  func part1() -> Any {
    let leftList: [Int] = entities[0].sorted()
    let rightList = entities[1].sorted()

    var result = 0
    for idx in leftList.indices {
      result += abs(leftList[idx] - rightList[idx])
    }

    return result
  }

  func part2() -> Any {
    var freq = [Int: Int]()
    let leftList = entities[0]
    for val in entities[1] {
      if let count = freq[val] {
        freq[val] = count + 1
      } else {
        freq[val] = 1
      }
    }

    return leftList.reduce(0) {
        $0 + $1 * (freq[$1] ?? 0)
    }
  }
}
