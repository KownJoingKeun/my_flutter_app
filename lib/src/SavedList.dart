import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedList extends StatefulWidget {
  SavedList({@required this.saved});

  final Set<WordPair> saved;

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("saved")),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    // ignore: missing_return
    return ListView.builder(
        itemCount: widget.saved.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();
          print(index);
          var realIndex = index ~/ 2;
          return _buildRow(widget.saved.toList()[realIndex]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        setState(() {
          widget.saved.remove(pair);
        });
      },
    );
  }
}
