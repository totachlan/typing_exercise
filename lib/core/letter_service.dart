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

  LetterService.aToZ() {
    const aToZ = "abcdefghijklmnopqrstuvwxyz";

    _letters = _parseStringToLetterLinkedList(aToZ);
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

  LinkedList<LetterEntry> getList() => _letters;
}
