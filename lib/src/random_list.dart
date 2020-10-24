import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:my_flutter_app/src/SavedList.dart';
import 'bloc/bloc.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _sugestions = <WordPair>[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("test app"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                bloc.savedStream;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SavedList()));
              })
        ],
      ),
      // ignore: missing_return
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          return ListView.builder(itemBuilder: (context, index) {
            if (index.isOdd) {
              return Divider();
            }
            var realIndex = index ~/ 2;

            if (realIndex >= _sugestions.length) {
              _sugestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(snapshot.data, _sugestions[realIndex]);
          });
        });
  }

  Widget _buildRow(Set<WordPair> saved, WordPair pair) {
    final bool alreadySaved = saved == null ? false : saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
}
