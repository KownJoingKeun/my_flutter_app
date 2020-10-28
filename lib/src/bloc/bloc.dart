import 'dart:async';
import 'package:english_words/english_words.dart';
import '../store/counter.dart';

class Bloc{
  Set<WordPair> saved = Set<WordPair>();

  final _savedController = StreamController<Set<WordPair>>.broadcast();

  get savedStream => _savedController.stream;

  get addCurrentSaved => _savedController.sink.add(saved);

  addToOrRemoveFromSavedList(WordPair item, Counter counter){
    if(saved.contains(item)){
      saved.remove(item);
      counter.decrement();
    }else{
      saved.add(item);
      counter.increment();
    }

    _savedController.sink.add(saved);
  }

  dispose(){
    _savedController.close();
  }
}



var bloc = Bloc();


