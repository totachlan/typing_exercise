import 'dart:collection';

class LetterEntry extends LinkedListEntry<LetterEntry> {
  final String letter;

  LetterEntry(this.letter);

  @override
  String toString() {
    return letter;
  }
}

class LetterService {
  late final LinkedList<LetterEntry> _letters;

  static const aToZLetters = "abcdefghijklmnopqrstuvwxyz";

  LetterService.aToZ() {
    _letters = _parseStringToLetterLinkedList(aToZLetters);
  }

  LetterService.fromString(String letters) {
    _letters = _parseStringToLetterLinkedList(letters);
  }

  LinkedList<LetterEntry> _parseStringToLetterLinkedList(String letters) {
    final list = LinkedList<LetterEntry>();
    for (var i = 0; i < letters.length; i += 1) {
      list.add(LetterEntry(letters[i]));
    }
    return list;
  }

  LinkedList<LetterEntry> getShuffleList() {
    final list = _letters.map((e) => e.letter).toList();
    list.shuffle();
    final listStr = list.join('');
    return _parseStringToLetterLinkedList(listStr);
  }

  LinkedList<LetterEntry> getList() => _letters;
}
