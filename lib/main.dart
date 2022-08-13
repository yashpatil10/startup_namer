// import 'package:flutter/material.dart';

// void main() {
//   runApp( MyApp());
// }

// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Welcome to Flutter'),
//         ),
//         body: const Center(
//           child: Text('Hello World'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}
//or// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Welcome to flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[]; //it is list of data type wordpairs
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Startup Name Generator'),backgroundColor: Color.fromARGB(255, 187, 201, 172) ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),

      /*
      7.1.
      ListView gives list but builder ables the edit in it.

      7.2.
      itemBuilder is called every time for ListView.Builder

      7.3.
      "i" down here is index, therefore if index is odd then put a Divider there, 
      ie. a one pixel line.

      7.4.
      if it is even 
      example :- 16 then index is 8;

      */
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); //this is infinity 
        }
        // if the suggestion generated are only 10 but index is 12 , 
        // so it will add suggestion in that list by using, 
        // the generateWordPairs() function
        // this generates infinity loop , but your device will not crash , 
        // as it will takes years of scrolling.
        return _buildRow(_suggestions[index]);
      },
    );
  }
}

Widget _buildRow(WordPair pair){
  const _biggerFont = TextStyle(fontSize: 18);
  return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
            
          ),
        );
}


/*
1.
Stateless widgets are immutable , 
Statefull widgets maintain state that might change in widget,
(Statefull requires 2 classes)

2.
We will create a class (state class) RandomWords : which is a child of Myapp stateless widget

3.
Prefixing an identifier with an underscore enforces privacy in the
Dart language and is a recommended best practice for State objects.

4.
The IDE also automatically updates the state class to extend State<RandomWords>,
indicating that you're using a generic State class specialized for use with RandomWords. 
Most of the app's logic resides here⁠—it maintains the state for 
the RandomWords widget.

5.
Most of the code for Statefull Widget is written in "state of StatefullWidget", 
here it is _RandomWordsState.

6.
Add a _suggestions list for saving suggested word pairings.  
Add a _biggerFont variable for making the font size larger.

*/