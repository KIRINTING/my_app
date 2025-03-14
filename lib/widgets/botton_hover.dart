import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final String bts;
  final VoidCallback onPressed;

  HoverButton({required this.bts, required this.onPressed});

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.blueAccent : Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.bts,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}