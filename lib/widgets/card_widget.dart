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
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant CardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.card.isFaceUp) {
      _controller.forward();
    } else {
      _controller.reverse();
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
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(rotation),
            child: _animation.value > 0.5
                ? Image.asset(widget.card.frontImage, fit: BoxFit.cover)
                : Image.asset('assets/images/card_back.png', fit: BoxFit.cover),
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
