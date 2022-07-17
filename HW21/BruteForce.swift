import Foundation

class BruteForce: Operation {

    var delegate: DisplaysThePasswordProtocol?
    var passwordToUnlock: String

    init(passwordToUnlock: String) {
        self.passwordToUnlock = passwordToUnlock
    }

    override func main() {
        guard !isCancelled else { return }
        bruteForce()
    }

    func bruteForce() {
        let arrayCharacters: [String] = String().printable.map { String($0) }
        var password: String = ""

        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: arrayCharacters)
            
            DispatchQueue.main.async {
                self.delegate?.displaysThePasswordLabel(password)
            }

            if self.isCancelled {
                DispatchQueue.main.async {
                    self.delegate?.cancellPasswordSelection(password)
                }
                return
            }
        }

        DispatchQueue.main.async {
            print("Finish")
            self.delegate?.displaysThePasswordLabel(password)
            self.delegate?.finishPasswordSelection(password)
        }
    }

    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
}
