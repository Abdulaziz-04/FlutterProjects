import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(this.col, this.childCard);
  final Color col;
  final Widget childCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: childCard,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: col,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
