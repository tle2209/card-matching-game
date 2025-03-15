class CardModel {
  final String frontImage;
  bool isFaceUp;
  bool isMatched;

  CardModel({required this.frontImage, this.isFaceUp = false, this.isMatched = false});
}
