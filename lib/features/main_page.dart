import 'package:flutter/material.dart';

import '../core/letter_service.dart';
import '../widget/error_letters_exercise_page.dart';
import '../widget/gesture_detector_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  var _letters = LetterService.aToZ().getList();
  var typedList = '';
  var typedErrorLetter = '';
  bool correct = false;
  var completeCount = 0;
  var errorCountMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GestureDetectorAppBar(
        onTap: () => focusNode.requestFocus(),
        appBar: AppBar(
          title: const Text('Typing Exercise'),
        ),
      ),
      floatingActionButton: errorCountMap.isNotEmpty
          ? FloatingActionButton(
              child: const Icon(Icons.arrow_circle_right_outlined),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ErrorLettersExercisePage())),
            )
          : null,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => focusNode.requestFocus(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Text(
                'Complete times: $completeCount',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 16.0),
              Text(
                _letters.first.letter,
                style: Theme.of(context).textTheme.headline3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        typedList,
                        style: const TextStyle(fontSize: 30.0),
                      ),
                      const SizedBox(width: 15.0),
                      SizedBox(
                        width: 20,
                        child: buildTextField(controller, focusNode),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: typedErrorLetter.isNotEmpty || correct == true,
                child: Column(
                  children: [
                    correct
                        ? const Text('Good!')
                        : Text('You typed: $typedErrorLetter,Try again!'),
                    correct ? const Icon(Icons.done) : const Icon(Icons.clear),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    errorCountMap.isEmpty
                        ? const SizedBox()
                        : Text(
                            'errors letter are (${errorCountMap.values.length}):'),
                  ],
                ),
              ),
              Expanded(
                child: buildListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    final keys = errorCountMap.keys;
    List<Widget> list = [];
    for (var i = 0; i < keys.length; i += 1) {
      final k = keys.elementAt(i);
      list.add(Text('$k: ${errorCountMap[k]}'));
    }
    return Wrap(
      direction: Axis.vertical,
      children: list,
    );
  }

  TextField buildTextField(
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLength: 1,
      showCursor: false,
      autofocus: true,
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 30.0),
        hintText: _letters.first.letter,
        counterText: "",
        border: InputBorder.none,
      ),
      onChanged: (v) {
        final l = _letters.first;

        if (_letters.first.letter == v) {
          setState(() {
            _letters.remove(l);
            typedList += v;
            correct = true;
          });
        } else {
          setState(() {
            errorCountMap[_letters.first.letter] =
                errorCountMap[_letters.first.letter] == null
                    ? 1
                    : errorCountMap[_letters.first.letter] += 1;
            correct = false;
            typedErrorLetter = _letters.first.letter;
          });
        }
        if (_letters.isEmpty) {
          completeCount += 1;
          typedList = '';
          _letters = LetterService.aToZ().getList();
        }
        controller.clear();
      },
    );
  }
}
