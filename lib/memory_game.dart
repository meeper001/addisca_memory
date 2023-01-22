import 'card.dart';

///Creates a game of memory with the selected number of cards.
class MemoryGame {
  int pairs;
  int tries = 0;
  int foundPairs = 0;
  List<MemoryCard> cards = [];
  MemoryCard? selectedFirst;
  MemoryCard? selectedSecond;

  MemoryGame(this.pairs) {
    for (int i = 0; i < pairs; i++) {
      cards.add(MemoryCard(i * 2, i));
      cards.add(MemoryCard(i * 2 + 1, i));
    }
    shuffleCards();
  }

  ///Shuffles the list of cards in the game.
  void shuffleCards() {
    cards.shuffle();
  }

  ///Resets all cards and the counters.
  void resetGame() {
    shuffleCards();
    for (var card in cards) {
      card.found = false;
      card.flipped = false;
    }
    tries = 0;
    foundPairs = 0;
  }

  ///Flips a card and checks if a pair is found.
  ///The return value indicates if the cards have to be flipped over again.
  ///If it is the first card it is saved to compare it to the second card.
  ///If its the second and the cards are a pair the are marked as found.
  bool selectCard(MemoryCard card) {
    if (!card.flipped) {
      card.flipped = true;
      if (selectedFirst == null) {
        selectedFirst = card;
        return false;
      } else {
        tries += 1;
        if (selectedFirst!.pairId == card.pairId) {
          selectedFirst!.found = true;
          card.found = true;
          foundPairs += 1;
          selectedFirst = null;
        } else {
          selectedSecond = card;
          return true;
        }
      }
    }
    return false;
  }

  ///Sets the selected cards back to the default position.
  void flipCards() {
    selectedFirst!.flipped = false;
    selectedSecond!.flipped = false;
    selectedFirst = null;
    selectedSecond = null;
  }
}
