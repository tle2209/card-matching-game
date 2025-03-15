import 'package:flutter/material.dart';
import '../models/card_model.dart';

class GameProvider extends ChangeNotifier {
  List<CardModel> _cards = [];
  CardModel? _firstSelectedCard;
  CardModel? _secondSelectedCard;
  bool _isProcessing = false;

  GameProvider() {
    _initializeCards();
  }

  List<CardModel> get cards => _cards;

  void _initializeCards() {
    List<String> images = [
      'assets/images/apple.png', 'assets/images/apple.png',
      'assets/images/banana.png', 'assets/images/banana.png',
      'assets/images/cherry.png', 'assets/images/cherry.png',
    ];
    images.shuffle();
    _cards = images.map((img) => CardModel(frontImage: img)).toList();
    notifyListeners();
  }

  void flipCard(CardModel card) {
    if (_isProcessing || card.isFaceUp || card.isMatched) return;

    card.isFaceUp = true;
    notifyListeners();

    if (_firstSelectedCard == null) {
      _firstSelectedCard = card;
    } else {
      _secondSelectedCard = card;
      _checkMatch();
    }
  }

  void _checkMatch() {
    if (_firstSelectedCard != null && _secondSelectedCard != null) {
      _isProcessing = true;

      if (_firstSelectedCard!.frontImage == _secondSelectedCard!.frontImage) {
        // Match found: Keep them face-up
        _firstSelectedCard!.isMatched = true;
        _secondSelectedCard!.isMatched = true;
      } else {
        // No match: Flip back after 1 second
        Future.delayed(Duration(seconds: 1), () {
          _firstSelectedCard!.isFaceUp = false;
          _secondSelectedCard!.isFaceUp = false;
          notifyListeners();
        });
      }

      // Reset selection after checking
      Future.delayed(Duration(milliseconds: 1000), () {
        _firstSelectedCard = null;
        _secondSelectedCard = null;
        _isProcessing = false;
        notifyListeners();
      });
    }
  }
}
