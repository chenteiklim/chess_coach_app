enum ChessPiecesType {
  pawn,
  rook,
  knight,
  bishop,
  king,
  queen,
}

class ChessPiece {
  ChessPiecesType type;
  final bool isWhite;
  String imagePath;

  ChessPiece(
      {required this.type, required this.isWhite, required this.imagePath});
}