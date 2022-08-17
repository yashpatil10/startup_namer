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
    
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,

      title: 'Startup Name Generator',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      )),
      home: const RandomWords(),
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
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>{}; //new_stuff
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions ',
            ),
          ],
        ),
        body: ListView.builder(
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
              _suggestions
                  .addAll(generateWordPairs().take(10)); //this is infinity
            }
            // if the suggestion generated are only 10 but index is 12 ,
            // so it will add suggestion in that list by using,
            // the generateWordPairs() function
            // this generates infinity loop , but your device will not crash ,
            // as it will takes years of scrolling.
            final alreadySaved = _saved.contains(_suggestions[index]);
            return ListTile(
                title: Text(
                  _suggestions[index].asPascalCase,
                  style: _biggerFont,
                ),
                trailing: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? 'Remove from saved ' : 'Save',
                ),
                onTap: () {
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(_suggestions[index]);
                    } else {
                      _saved.add(_suggestions[index]);
                    }
                  });
                });
          },
        ));
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
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

8.
workshop (part2)
 --> creating a _saved var or set for storing favorite names, in 
_RandomWordsState.

--> trailing : is used for aligning any thing to extreme right, 
here icon is placed 

--> in Icon we are using alreadySaved as a bool 
and 
if it is saved
  alreadySaved ? Icons.favorite : Icons.favorite_border, // if saved then favorite icon else only border
  color: alreadySaved ? Colors.red : null,                //if saved then color red or null
  semanticLabel: alreadySaved ? 'Remove from saved ' : 'Save', 

9.
adding a new page called route in flutter, which displays favorites
the Navigator manages a stack containing the app's routes. Pushing a route onto the Navigator's stack
updates the display to that route. Popping a route from
the Navigator's stack returns the display 


10.
need to add list view in title, so "action" is added in the appBar section
with IconButton

11.
 build a route and push it to the Navigator's stack,
 this action displays new screen, call " Navigator.push " 

 12. what is (build context) or (context)
 in build method 
 widget does not keep track of where it is placed on screen , 
 so in stateless and statefull widget they are made form class widget
 in this base class we have "Element" which keeps track of the widget
 so here the Element is type of build context

 13.
 MaterialPageRoute and its builder. For now, add the code that 
 generates the ListTile rows. The divideTiles() method of ListTile 
 adds horizontal spacing between each ListTile. The divided variable 
 holds the final rows converted to a list by the convenience function, 
 toList()
*/
