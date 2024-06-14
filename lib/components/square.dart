import 'package:chess_coach_app2/components/pieces.dart';
import 'package:chess_coach_app2/values/colors.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final void Function()? onTap;
  final bool isValidMove;
  final bool isSquareWhite;
  final ChessPiece? piece;
  final bool isSelected;
  const Square(
      {super.key,
        required this.onTap,
        required this.isValidMove,
        required this.isSquareWhite,
        required this.piece,
        required this.isSelected});

  @override
  Widget build(BuildContext context) {
    Color? squareColor;

    if (isSelected) {
      squareColor = Colors.green;
    } else if (isValidMove) {
      squareColor = Colors.green[300];
    }
// otherwise, it's white or black
    else {
      squareColor = isSquareWhite ? backgroundColor : forgroundColor;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squareColor,
        child: piece != null
            ? Image.asset(
          piece!.imagePath,
          color: piece!.isWhite ? null : Colors.black,
        )
            : null,
      ),
    );
  }
}