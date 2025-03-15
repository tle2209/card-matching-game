import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';
import '../providers/game_provider.dart';

class CardWidget extends StatefulWidget {
  final CardModel card;
  CardWidget({required this.card});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.card.isMatched) {
          Provider.of<GameProvider>(context, listen: false).flipCard(widget.card);
          if (widget.card.isFaceUp) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_animation.value * 3.14),
            child: _animation.value > 0.5
                ? Image.asset(widget.card.frontImage)
                : Image.asset('assets/images/card_back.png'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
