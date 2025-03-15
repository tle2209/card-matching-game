import 'package:flutter/material.dart';
import '../models/card_model.dart';

class GameProvider extends ChangeNotifier {
  List<CardModel> _cards = [];
  CardModel? _firstSelectedCard;
  CardModel? _secondSelectedCard;

  GameProvider() {
    _initializeCards();
  }

  List<CardModel> get cards => _cards;

  void _initializeCards() {
    List<String> images = [
      'assets/images/apple.png', 'assets/images/apple.png',
      'assets/images/banana.png', 'assets/images/banana.png',
      // Add more pairs
    ];
    images.shuffle();
    _cards = images.map((img) => CardModel(frontImage: img)).toList();
    notifyListeners();
  }

  void flipCard(CardModel card) {
    if (_firstSelectedCard == null) {
      _firstSelectedCard = card;
    } else {
      _secondSelectedCard = card;
      _checkMatch();
    }
    card.isFaceUp = true;
    notifyListeners();
  }

  void _checkMatch() {
    if (_firstSelectedCard != null && _secondSelectedCard != null) {
      if (_firstSelectedCard!.frontImage == _secondSelectedCard!.frontImage) {
        _firstSelectedCard!.isMatched = true;
        _secondSelectedCard!.isMatched = true;
      } else {
        Future.delayed(Duration(seconds: 1), () {
          _firstSelectedCard!.isFaceUp = false;
          _secondSelectedCard!.isFaceUp = false;
          notifyListeners();
        });
      }
      _firstSelectedCard = null;
      _secondSelectedCard = null;
    }
  }
}
