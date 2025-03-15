import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardWidget extends StatefulWidget {
  final CardModel card;
  final VoidCallback onTap;

  const CardWidget({Key? key, required this.card, required this.onTap}) : super(key: key);

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
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void didUpdateWidget(CardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.card.isFaceUp) {
      _controller.forward(); // Flip to face-up
    } else {
      _controller.reverse(); // Flip to face-down
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final rotation = _animation.value * 3.14;
          final isFlipped = _animation.value > 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(rotation),
            child: isFlipped
                ? Image.asset(widget.card.frontImage, fit: BoxFit.cover) // Show front image
                : Image.asset('assets/images/card_back.png', fit: BoxFit.cover), // Show back image
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
