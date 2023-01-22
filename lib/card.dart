///Creates a card for a memory game.
class MemoryCard {
  int id;
  int pairId;
  bool flipped;
  bool found;

  MemoryCard(this.id, this.pairId, {this.flipped = false, this.found = false});
}
