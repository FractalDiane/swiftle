// SWIFTLE
// That one word guessing game in Swift
// By Diane Sparks

import Rainbow;

func printGuesses(_ guesses: [String]) {
	print()
	for i in 0..<6 {
		print(i < guesses.count ? guesses[i] : "■■■■■")
	}

	print()
}

func printLettersGuessed(_ guessed: Set<Character>) {
	var output = "Letters guessed: "

	let guessedArray = guessed.sorted()
	output.reserveCapacity(50)
	for letter in guessedArray {
		output += "\(String(letter).uppercased()) "
	}

	print(output)
}

let words = [
	"thing", "miser", "stone", "color", "swift", "glass", "plate", "crack", "table", "index",
	"never", "shard", "cabin", "freed", "shade", "solar", "clear", "vigil", "quest", "exalt",
	"three", "seven", "river", "plain", "demon", "worst", "sauce", "shift", "coded", "paste",
	"empty", "sever", "rider", "flint", "minus", "robot", "brass", "quail", "cling", "grace"]

print("SWIFTLE\n")
printGuesses([])

gameLoop: while true {
	let targetWord = words.randomElement()!
	var targetCharCounts: [Character:Int] = [:]
	for char in targetWord {
		targetCharCounts[char, default: 0] += 1
	}

	var guesses: Int8 = 6
	var guessStrings: [String] = []
	var lettersGuessed: Set<Character> = []
	
	while guesses > 0 {
		var input = String()
		repeat {
			input = readLine() ?? String()
		} while input.count != 5 || input.contains(where: { !$0.isLetter})

		var matches: Int8 = 0
		var output = String()
		var counts = targetCharCounts
		for i in input.indices {
			let guessChar = Character(String(input[i]).lowercased())
			let outputChar = String(guessChar).uppercased()
			lettersGuessed.insert(guessChar)
			
			if let index = targetWord.firstIndex(of: guessChar) {
				if index == i {
					output += outputChar.black.onGreen
					matches += 1
					counts[guessChar, default: 0] -= 1
				} else if counts[guessChar] ?? 0 > 0 {
					output += outputChar.black.onYellow
					counts[guessChar, default: 0] -= 1
				} else {
					output += outputChar
				}
			} else {
				output += outputChar
			}
		}

		guessStrings.append(output)
		printGuesses(guessStrings)
		printLettersGuessed(lettersGuessed)

		if matches == 5 {
			print("YOU WON!")
			break gameLoop
		}

		guesses -= 1
		if (guesses == 0) {
			print("YOU LOST")
			print("The word was \(targetWord.uppercased())")
			break gameLoop
		}
	}
}
