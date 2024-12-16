import 'package:flutter/material.dart';

class Mybutton extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final VoidCallback buttonTapped;

  Mybutton({
    required this.color,
    required this.textColor,
    required this.buttonText,
    required this.buttonTapped,
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<Mybutton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
    widget.buttonTapped();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: Transform.scale(
          scale: _isPressed ? 0.95 : 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isPressed
                  ? []
                  : [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.buttonText,
                style: TextStyle(color: widget.textColor, fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
