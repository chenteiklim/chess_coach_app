import 'package:chess_coach_app2/components/pieces.dart';
import 'package:chess_coach_app2/components/square.dart';
import 'package:flutter/material.dart';
import 'helper/helper_function.dart';
import 'package:chess_coach_app2/main.dart';
import 'dart:math' as math; // for pi constant

class Move {
  int id;
  int startRow;
  int startCol;
  int endRow;
  int endCol;
  ChessPiece pieceMoved;
  ChessPiece pieceCaptured;

  Move({
    required this.id,
    required this.startRow,
    required this.startCol,
    required this.endRow,
    required this.endCol,
    required this.pieceMoved,
    required this.pieceCaptured,
  });
}

class BoardGame extends StatefulWidget {

  const BoardGame({Key? key}) : super(key: key);

  @override
  State<BoardGame> createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {
  bool _isBoardRotated = false;

  void _toggleRotation() {
    setState(() {
      _isBoardRotated = true;
      _initializeBoard2();
    });
  }

  int _moveId = 1;
  List<int> previousKingPosition = [];
  late List<List<ChessPiece?>> board;

  // The currently selected piece on the chess board,
// If no piece is selected, this is null.
  ChessPiece? selectedPiece;
// The row index of the selected piece
// Default value -1 indicated no piece is currently selected;
  int selectedRow = -1;

// The Column index of the selected piece
// Default value -1 indicated no piece is currently selected;
  int selectedCol = -1;
  List<List<int>> validMoves = [];

  List<ChessPiece?> whitePiecesTaken = [];

  List<ChessPiece?> blackPiecesTaken = [];

  bool isWhiteTurn = true;

  List<int> whiteKingPosition = [7, 4];
  List<int> blackKingPosition = [0, 4];
  bool checkStatus = false;

  @override
  void initState() {

    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    // initialize the board with nulls, meaning no pieces in those positions.
    List<List<ChessPiece?>> newBoard = List.generate(8, (indexes) {
      return List.generate(8, (indexes) {
        return null;
      });
    });
    // Place pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPiecesType.pawn,
        isWhite: false,
        imagePath: 'assets/pawn.png',
      );

      newBoard[6][i] = ChessPiece(
        type: ChessPiecesType.pawn,
        isWhite: true,
        imagePath: 'assets/pawn.png',

      );
    }

    // Place rooks
    newBoard[0][0] = ChessPiece(
      type: ChessPiecesType.rook,
      isWhite: false,
      imagePath: "assets/rook.png",

    );



    newBoard[0][7] = ChessPiece(
      type: ChessPiecesType.rook,
      isWhite: false,
      imagePath: "assets/rook.png",

    );
    newBoard[7][0] = ChessPiece(
      type: ChessPiecesType.rook,
      isWhite: true,
      imagePath: "assets/rook.png",

    );
    newBoard[7][7] = ChessPiece(
      type: ChessPiecesType.rook,
      isWhite: true,
      imagePath: "assets/rook.png",

    );

    // Place knights
    newBoard[0][1] = ChessPiece(
      type: ChessPiecesType.knight,
      isWhite: false,
      imagePath: "assets/knight.png",

    );
    newBoard[0][6] = ChessPiece(
      type: ChessPiecesType.knight,
      isWhite: false,
      imagePath: "assets/knight.png",

    );
    newBoard[7][1] = ChessPiece(
      type: ChessPiecesType.knight,
      isWhite: true,
      imagePath: "assets/knight.png",

    );
    newBoard[7][6] = ChessPiece(
      type: ChessPiecesType.knight,
      isWhite: true,
      imagePath: "assets/knight.png",

    );

    // Place bishops
    newBoard[0][2] = ChessPiece(
      type: ChessPiecesType.bishop,
      isWhite: false,
      imagePath: "assets/bishop.png",

    );

// Place bishops
    newBoard[0][5] = ChessPiece(
      type: ChessPiecesType.bishop,
      isWhite: false,
      imagePath: "assets/bishop.png",

    );
    newBoard[7][2] = ChessPiece(
      type: ChessPiecesType.bishop,
      isWhite: true,
      imagePath: "assets/bishop.png",

    );

    newBoard[7][5] = ChessPiece(
      type: ChessPiecesType.bishop,
      isWhite: true,
      imagePath: "assets/bishop.png",

    );

    // Place queens
    newBoard[0][3] = ChessPiece(
      type: ChessPiecesType.queen,
      isWhite: false,
      imagePath: 'assets/queen.png',

    );
    newBoard[7][3] = ChessPiece(
      type: ChessPiecesType.queen,
      isWhite: true,
      imagePath: 'assets/queen.png',

    );

    // Place kings
    newBoard[0][4] = ChessPiece(
      type: ChessPiecesType.king,
      isWhite: false,
      imagePath: 'assets/king.png',

    );
    newBoard[7][4] = ChessPiece(
      type: ChessPiecesType.king,
      isWhite: true,
      imagePath: 'assets/king.png',

    );

    board = newBoard;
  }

  void _initializeBoard2() {
    isWhiteTurn = true;
    print('is initializeBoard2');
    // initialize the board with nulls, meaning no pieces in those positions.
    List<List<ChessPiece?>> newBoard = List.generate(8, (indexes) {
      return List.generate(8, (indexes) {
        return null;
      });
    });
    // Place pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPiecesType.pawn,
        isWhite: false,
        imagePath: 'assets/pawnRotate.png',
      );

      newBoard[6][i] = ChessPiece(
        type: ChessPiecesType.pawn,
        isWhite: true,
        imagePath: 'assets/pawnRotate.png',

      );
    }

    // Place rooks
    newBoard[0][0] = ChessPiece(
      type: ChessPiecesType.rook,
      isWhite: false,
      imagePath: "assets/rookRotate.png",

    );



    newBoard[0][7] = ChessPiece(
      type: ChessPiecesType.rook,
      isWhite: false,
      imagePath: "assets/rookRotate.png",

    );
    newBoard[7][0] = ChessPiece(
      type: ChessPiecesType.rook,
      isWhite: true,
      imagePath: "assets/rookRotate.png",

    );
    newBoard[7][7] = ChessPiece(
      type: ChessPiecesType.rook,
      isWhite: true,
      imagePath: "assets/rookRotate.png",

    );

    // Place knights
    newBoard[0][1] = ChessPiece(
      type: ChessPiecesType.knight,
      isWhite: false,
      imagePath: "assets/knightRotate.png",

    );
    newBoard[0][6] = ChessPiece(
      type: ChessPiecesType.knight,
      isWhite: false,
      imagePath: "assets/knightRotate.png",

    );
    newBoard[7][1] = ChessPiece(
      type: ChessPiecesType.knight,
      isWhite: true,
      imagePath: "assets/knightRotate.png",

    );
    newBoard[7][6] = ChessPiece(
      type: ChessPiecesType.knight,
      isWhite: true,
      imagePath: "assets/knightRotate.png",

    );

    // Place bishops
    newBoard[0][2] = ChessPiece(
      type: ChessPiecesType.bishop,
      isWhite: false,
      imagePath: "assets/bishopRotate.png",

    );

// Place bishops
    newBoard[0][5] = ChessPiece(
      type: ChessPiecesType.bishop,
      isWhite: false,
      imagePath: "assets/bishopRotate.png",

    );
    newBoard[7][2] = ChessPiece(
      type: ChessPiecesType.bishop,
      isWhite: true,
      imagePath: "assets/bishopRotate.png",

    );

    newBoard[7][5] = ChessPiece(
      type: ChessPiecesType.bishop,
      isWhite: true,
      imagePath: "assets/bishopRotate.png",

    );

    // Place queens
    newBoard[0][3] = ChessPiece(
      type: ChessPiecesType.queen,
      isWhite: false,
      imagePath: 'assets/queenRotate.png',

    );
    newBoard[7][3] = ChessPiece(
      type: ChessPiecesType.queen,
      isWhite: true,
      imagePath: 'assets/queenRotate.png',

    );

    // Place kings
    newBoard[0][4] = ChessPiece(
      type: ChessPiecesType.king,
      isWhite: false,
      imagePath: 'assets/kingRotate.png',

    );
    newBoard[7][4] = ChessPiece(
      type: ChessPiecesType.king,
      isWhite: true,
      imagePath: 'assets/kingRotate.png',

    );

    board = newBoard;
  }

// USER SELECTED A PIECE
  void pieceSelected(int row, int col) {
    setState(() {
      if (selectedPiece == null && board[row][col] != null) {
        if (board[row][col]!.isWhite == isWhiteTurn) {
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
        }
      } else if (board[row][col] != null &&
          board[row][col]!.isWhite == selectedPiece!.isWhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      } else if (selectedPiece != null &&
          validMoves.any((element) {
            print('Element 0: ${element[0]}, Element 1: ${element[1]}');
            return element[0] == row && element[1] == col;
          })) {
        movePiece(row, col);
      }
      print('Valid Moves: $validMoves');
      validMoves = calculateRealValidMoves(
          selectedRow, selectedCol, selectedPiece, true);
      print('Valid Moves: $validMoves');

    });
  }

  List<List<int>> calculateRowValidMoves(int row,  int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];
    if (piece == null) {
      return [];
    }

    int direction = piece.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPiecesType.pawn:
        if (row == 0 && piece.isWhite) {
          piece.type = ChessPiecesType.queen;
          piece.imagePath = 'assets/queen.png';
        }
        if (row == 7 && !piece.isWhite) {
          piece.type = ChessPiecesType.queen;
          piece.imagePath = 'assets/queen.png';
        }

        // Check the square immediately in front of the pawn
        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        // If it's the pawn's first move (row is either 1 for black pawns or 6 for white ones), check the square two steps ahead
        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        // Check for possible captures
        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite != piece.isWhite) {

          candidateMoves.add([row + direction, col + 1]);
        }
        if (isInBoard(row , col - 1) &&
            (row == 3) &&
            board[row ][col - 1] != null &&
            board[row ][col - 1]!.isWhite != piece.isWhite &&
            piece.isWhite == true
        )

        {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row , col + 1) &&
            (row == 3) &&
            board[row ][col + 1] != null &&
            board[row ][col + 1]!.isWhite != piece.isWhite &&
            piece.isWhite == true
        )
        {
          candidateMoves.add([row + direction, col + 1]);
        }
        if (isInBoard(row + direction, col - 1) &&
            ( row == 4) &&
            board[row][col - 1] != null &&
            board[row][col - 1]!.isWhite != piece.isWhite &&
            piece.isWhite == false
        )
        {
          candidateMoves.add([row + direction, col + 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            ( row == 4) &&
            board[row][col + 1] != null &&
            board[row][col + 1]!.isWhite != piece.isWhite &&
            piece.isWhite == false
        )
        {
          candidateMoves.add([row + direction, col + 1]);
        }

        break;
      case ChessPiecesType.king:
        var kingMoves = [
          [-1, -1], // Up-left
          [-1, 0], // Up
          [-1, 1], // Up-right
          [0, -1], // Left
          [0, 1], // Right
          [1, -1], // Down-left
          [1, 0], // Down
          [1, 1] // Down-right
        ];

        for (var move in kingMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];

          if (!isInBoard(newRow, newCol)) {
            continue;
          }

          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); // Can capture
            }
            continue; // Square is blocked by a piece of the same color
          }
          candidateMoves.add([newRow, newCol]);
        }
        if ((row == 7) && (col==4) &&
            board[7][5] == null && board[7][6] == null &&
            piece.isWhite == true
        )

        {
          candidateMoves.add([7, col + 2]);
        }
        if ((row == 7) && (col==4) &&
            board[7][2] == null && board[7][3] == null &&
            piece.isWhite == true
        )

        {
          candidateMoves.add([7, col - 2]);
        }
        if ((row == 0) && (col==4) &&
            board[0][5] == null && board[0][6] == null &&
            piece.isWhite == false
        )

        {
          candidateMoves.add([0, col + 2]);
        }
        if ((row == 0) && (col==4) &&
            board[0][2] == null && board[0][3] == null &&
            piece.isWhite == false
        )

        {
          candidateMoves.add([0, col - 2]);
        }



        break;

      case ChessPiecesType.rook:
        if ((row == 7) && (col == 7) && piece.isWhite)  {
          candidateMoves.add([7, col - 2]);
        }
        if ((row == 7) && (col == 0) && piece.isWhite)  {
          candidateMoves.add([7, col + 3]);
        }
        if ((row == 0) && (col == 0) && !piece.isWhite)  {
          candidateMoves.add([0, col + 3]);
        }
        if ((row == 0) && (col == 7) && !piece.isWhite)  {
          candidateMoves.add([0, col - 2]);
        }
        // horizontal and vertical directions
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], //left
          [0, 1], //right
        ];


        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves
                    .add([newRow, newCol]); // can capture opponent's piece
              }
              break; // blocked by own piece or after capturing
            }
            candidateMoves.add([newRow, newCol]); // an empty valid square
            i++;
          }

        }


      case ChessPiecesType.knight:
      // all eight possible L shapes the knight can move
        var knightMoves = [
          [-2, -1], // up 2 left 1
          [-2, 1], // up 2 right 1
          [-1, -2], // up 1 left 2
          [-1, 2], // up 1 right 2
          [1, -2], // down 1 left 2
          [1, 2], // down 1 right 2
          [2, -1], // down 2 left 1
          [2, 1], // down 2 right 1
        ];
        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          // if the new position is empty or there is an opponent's piece there
          if (board[newRow][newCol] == null ||
              board[newRow][newCol]!.isWhite != piece.isWhite) {
            candidateMoves.add([newRow, newCol]);
          }
        }
        break;

      case ChessPiecesType.bishop:
      // diagonal directions
        var directions = [
          [-1, -1], // up-left
          [-1, 1], // up-right
          [1, -1], // down-left
          [1, 1], // down-right
        ];
        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // capture
              }
              break; // blocked
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;

      case ChessPiecesType.queen:
      // Queen can move in any direction, combining the moves of a rook and a bishop
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
          [-1, -1], // up-left
          [-1, 1], // up-right
          [1, -1], // down-left
          [1, 1] // down-right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];

            if (!isInBoard(newRow, newCol)) {
              break;
            }

            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // capture
              }
              break; // blocked
            }
            candidateMoves.add([newRow, newCol]); // free space
            i++;
          }

        }
        break;



      default:
    }
    return candidateMoves;
  }

  List<List<int>> calculateRealValidMoves(
      int row, int col, ChessPiece? piece, bool checkSimulation) {
    List<List<int>> realValidMoves = [];
    List<List<int>> candidateMoves = calculateRowValidMoves(row, col, piece);
    if (checkSimulation) {
      for (var move in candidateMoves) {
        int endRow = move[0];
        int endCol = move[1];
        if (simulatedMoveIsSafe(piece!, row, col, endRow, endCol)) {
          realValidMoves.add(move);
        }
      }
    } else {
      realValidMoves = candidateMoves;
    }
    return realValidMoves;
  }

  void movePiece(int newRow, int newCol ) {
    bool whiteShortCastle = false;
    bool whiteLongCastle = false;
    bool blackShortCastle = false;
    bool blackLongCastle = false;

    if (selectedPiece?.type == ChessPiecesType.king && board[7][6] == null && selectedPiece?.isWhite == true  ) {
      // Save the previous king position
      // Check for short castling and update whiteShortCastle
      whiteShortCastle = true;

    }
    if (selectedPiece?.type == ChessPiecesType.king && board[7][3] == null && selectedPiece?.isWhite == true  ) {
      // Save the previous king position

      // Check for short castling and update whiteShortCastle
      whiteLongCastle = true;

    }

    if (selectedPiece?.type == ChessPiecesType.king && board[0][6] == null && selectedPiece?.isWhite == false  ) {
      // Save the previous king position

      // Check for short castling and update whiteShortCastle
      blackShortCastle = true;

    }
    if (selectedPiece?.type == ChessPiecesType.king && board[0][3] == null && selectedPiece?.isWhite == false ) {
      // Save the previous king position

      // Check for short castling and update whiteShortCastle
      blackLongCastle = true;

    }

// if the new spot has an enemy piece
    bool isEnPassant = false;
    // Check for en passant
    if (selectedPiece?.type == ChessPiecesType.pawn) {
      if ((selectedRow == 3 && newRow == 2 && board[3][newCol]?.type == ChessPiecesType.pawn && board[3][newCol]?.isWhite != selectedPiece!.isWhite) ||
          (selectedRow == 4 && newRow == 5 && board[4][newCol]?.type == ChessPiecesType.pawn && board[4][newCol]?.isWhite != selectedPiece!.isWhite)) {
        isEnPassant = true;
      }
    }

    // If the new spot has an enemy piece or it's an en passant capture
    if (board[newRow][newCol] != null || isEnPassant) {
      // Add the captured piece to the appropriate list
      var capturedPiece = isEnPassant ? board[selectedRow][newCol] : board[newRow][newCol];
      if (capturedPiece!.isWhite) {
        whitePiecesTaken.add(capturedPiece);
      } else {
        blackPiecesTaken.add(capturedPiece);
      }

      // Remove the captured pawn in en passant
      if (isEnPassant) {
        board[selectedRow][newCol] = null;
      }
    }



    if (selectedPiece?.type == ChessPiecesType.king) {
      if (selectedPiece!.isWhite) {
        whiteKingPosition = [newRow, newCol];
      } else {
        blackKingPosition = [newRow, newCol];
      }
    }

    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    if (isKingInCheck(!isWhiteTurn)) {
      checkStatus = true;
    } else {
      checkStatus = false;
    }

    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
      _moveId++;
      print(_moveId);
    });

    if (isCheckMate(!isWhiteTurn)) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("CHECK MATE"),
            actions: [
              TextButton(
                  onPressed: resetGame, child: Text("Restart The Game"))
            ],
          ));
    }

    isWhiteTurn = !isWhiteTurn;
    if (whiteShortCastle){
      isWhiteTurn = true;
    }
    if (whiteLongCastle){
      isWhiteTurn = true;
    }
    if (blackShortCastle){
      isWhiteTurn = false;
    }
    if (blackLongCastle){
      isWhiteTurn = false;
    }

  }

  bool isKingInCheck(bool isWhiteKing) {
    List<int> kingPosition =
    isWhiteKing ? whiteKingPosition : blackKingPosition;

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == null || board[i][j]!.isWhite == isWhiteKing) {
          continue;
        }
        List<List<int>> pieceValidMoves =
        calculateRealValidMoves(i, j, board[i][j], false);

        for (List<int> move in pieceValidMoves) {
          if (move[0] == kingPosition[0] && move[1] == kingPosition[1]) {
            return true;
          }
        }
      }
    }
    return false;
  }

  bool simulatedMoveIsSafe(
      ChessPiece piece, int startRow, int startCol, int endRow, int endCol) {
    ChessPiece? originalDestinationPiece = board[endRow][endCol];

    List<int>? originalKingPosition;
    if (piece.type == ChessPiecesType.king) {
      originalKingPosition =
      piece.isWhite ? whiteKingPosition : blackKingPosition;

      if (piece.isWhite) {
        whiteKingPosition = [endRow, endCol];
      } else {
        blackKingPosition = [endRow, endCol];
      }
    }

    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;

    bool kingInCheck = isKingInCheck(piece.isWhite);

    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestinationPiece;

    if (piece.type == ChessPiecesType.king) {
      if (piece.isWhite) {
        whiteKingPosition = originalKingPosition!;
      } else {
        blackKingPosition = originalKingPosition!;
      }
    }
    return !kingInCheck;
  }

  bool isCheckMate(bool isWhiteKing) {
    if (!isKingInCheck(isWhiteKing)) {
      return false;
    }
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == null || board[i][j]!.isWhite != isWhiteKing) {
          continue;
        }
        List<List<int>> validMoves =
        calculateRealValidMoves(i, j, board[i][j]!, true);
        if (validMoves.isNotEmpty) {
          return false;
        }
      }
    }
    return true;
  }
  void resetGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BoardGame()),
    );
    _initializeBoard();
    checkStatus = false;
    whitePiecesTaken.clear();
    blackPiecesTaken.clear();
    whiteKingPosition = [7, 4];
    blackKingPosition = [0, 4];
    isWhiteTurn = true;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: 500,
            height: 90,
            color: Colors.greenAccent,
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      resetGame(); // Call the resetGame function here
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      minimumSize: MaterialStateProperty.all<Size>(Size(80, 35)),
                    ),
                    child: Text(
                      'play as white',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      minimumSize: MaterialStateProperty.all<Size>(Size(70, 35)),
                    ),
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: _toggleRotation,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      minimumSize: MaterialStateProperty.all<Size>(Size(70, 35)),
                    ),
                    child: Text(
                      'play as black',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chessboard component
          Row(
            children: [
              Transform(
                alignment: Alignment.center,
                child: Container(
                  width: 400, // Reduced width to make the chessboard smaller
                  height: 450, // Reduced height to make the chessboard smaller
                  padding: EdgeInsets.all(4), // Added padding besides container
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8 * 8,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,

                    ),
                    itemBuilder: (context, indexeg) {
                      int row = indexeg ~/ 8;
                      int col = indexeg % 8;
                      print('Row: $row, Col: $col, Index: $indexeg');
                      bool isSelected = selectedCol == col && selectedRow == row;
                      bool isValidMove = false;
                      for (var position in validMoves) {
                        if (position[0] == row && position[1] == col) {
                          isValidMove = true;
                        }
                      }

                      return SizedBox(

                        child: Square(
                          isValidMove: isValidMove,
                          onTap: () {
                            pieceSelected(row, col);
                            print('Selected Index: $indexeg');// Print the index here
                          },
                          isSelected: isSelected,
                          isSquareWhite: isSquareWhite(indexeg),
                          piece: board[row][col],
                        ),
                      );
                    },
                  ),
                ),

                transform: _isBoardRotated ? Matrix4.rotationZ(math.pi) : Matrix4.identity(), // Apply rotation based on state
              ),
              Column(


                children: [
                  if (_isBoardRotated)
                  // Loop for rotated orientation (i = 8 to 1)
                    for (int i = 1; i <= 8; i++)
                      Padding(
                        padding: EdgeInsets.only(top: i == 1 ? 25 : 25),
                        child: Text(
                          '$i',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                  if (!_isBoardRotated)
                  // Loop for normal orientation (i = 1 to 8)
                    for (int i = 8; i >= 1; i--)
                      Padding(
                        padding: EdgeInsets.only(top: i == 1 ? 25 : 25),
                        child: Text(
                          '$i',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                ],

              ),
            ],
          ),
          Container(
            width: 400,
            height: 40,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var letter in ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'])
                  Padding(
                    padding: EdgeInsets.only(left: letter == 'a' ? 0 : 3),
                    child: Text(
                      letter,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: 500,
            height:200,
            color: Colors.black,
            // Label above the chessboard
            padding: const EdgeInsets.only(left: 20, top: 30,),
            child: Text(
              '${_moveId == 1
                  ? 'White start with d4 which most easiest to recognized its pattern.'
                  : _moveId == 2
                  ? 'It\'s black\'s turn to move. Black has many options here. Now d5. d5 frees up the square of the dark square bishop and controls the center squares, c4 and e4.'
                  : _moveId == 3
                  ? 'Now white can choose to gambit the pawn or continue developing pieces. Let\'s continue developing pieces with Ng3-f3.'
                  : _moveId == 4
                  ? 'Black need to develop the piece, The more the pieces, the more weapon to destroy opponent. Now Ng8-f6'
                  : _moveId == 5
                  ? 'White can move the powerful bishop the most active square, now bc1-f4'
                  : _moveId == 6
                  ? 'Black does the same by activating bishop, now bc8-f5'
                  : _moveId == 7
                  ? 'Following principle of chess, knight before bishop, knight c3 is playable but will blocking c2 pawn, now kb1-d2'
                  : _moveId == 8
                  ? 'Black also activate knight toward center, now kb8-d4'
                  : _moveId == 9
                  ? 'One more bishop need to be activated, now e3'
                  : _moveId == 10
                  ? 'black also does the same, e6'
                  : _moveId == 11
                  ? 'Black keep copying white, if keep progress like this will be draw which white dun want, now c4, do some pawn break, maintain tension and time for attack. Without pawn break mean waiting to defense which harder to play'
                  : _moveId == 12
                  ? 'Black accept the tension, taking pawn is no good since it help white activate light square bishop. Now bf8-e7. Black try to play solid since defense is needed when facing attack. '
                  : _moveId == 13
                  ? 'One more bishop need to be activated, now bf1-f2'
                  : _moveId == 14
                  ? 'After finish development need castle, now black castle king side'
                  : _moveId == 15
                  ? 'After finish development need castle, now black castle king side'
                  : _moveId == 16
                  ? 'White does the same, now castle'
                  : _moveId == 17
                  ? 'White does the same, now castle'
                  : _moveId == 18
                  ? 'Light square bishop is annoying, now kf6-g5'
                  : _moveId == 19
                  ? 'White want to avoid being capture by this knight on the edge. make it out of the game, bf4-e5 '
                  : _moveId == 20
                  ? 'Capturing bishop is not good it follow by dxe5 which leave Nh5 remain at edge of board,now Nh5-f6'
                  : _moveId == 21
                  ? 'bishop worth more than knight now, be5-g3'
                  : _moveId == 22
                  ? 'h6, avoid backrank mate and free up square for bf5'
                  : _moveId == 23
                  ? 'White does the same, h3'
                  : _moveId == 24
                  ? 'c6, solidified the center, the more solid center has, the harder white to win'
                  : _moveId == 25
                  ? 'Activate your queen to most active square and cause threat, now Qd1-b3'
                  : _moveId == 26
                  ? 'Qd8-c8 to defense the pawn '
                  : _moveId == 27
                  ? 'align rook same rank with opponent queen, now Rf1-c1. it will pin the opponent c6'
                  : _moveId == 28
                  ? 'a5 to gaining some space'
                  : _moveId == 29
                  ? 'c5 to restrict opponent bishop and cause b7 backward pawn'
                  : _moveId == 30
                  ? 'bd8 to trade inactive dark square bishop with white active dark square bishop'
                  : _moveId == 31
                  ? 'Qc1 to overprotect e5 square'
                  : _moveId == 32
                  ? 'bc7 to trade bishop'
                  : _moveId == 33
                  ? 'bg3xc7 since bishop is no other good square to run'
                  : _moveId == 34
                  ? 'Q take c7 regaining material'
                  : _moveId == 35
                  ? 'a3. Trying to gain some space on queen side by a3 follow by b4'
                  : _moveId == 36
                  ? 'a4, to prevent white has strong pawn chain since can en-passant'
                  : _moveId == 37
                  ? 'b4, still need some pawn break though black can capture. Otherwise it is draw'
                  : _moveId == 38
                  ? 'en-passant'
                  : _moveId == 39
                  ? 'Nd2xb3, Regain pawn'
                  : _moveId == 40
                  ? 'Ne4 attack the queen'
                  : _moveId == 41
                  ? 'Qb2 running away'
                  : _moveId == 42
                  ? 'Rf1-b1 allign rook with queen'
                  : _moveId == 43
                  ? 'a4, gaining some space'
                  : _moveId == 44
                  ? 'b6 to start pawn break since rook align with queen'
                  : _moveId == 45
                  ? 'c5xb6 to open up the rook and cause c6 backward pawn'
                  : _moveId == 46
                  ? 'Qc7 takes b6 to avoid align with rook and put more pressure on Nb3'
                  : _moveId == 47
                  ? 'ra3 protect the knight'
                  : _moveId == 48
                  ? 'Qb4 to infiltrate white position'
                  : _moveId == 49
                  ? 'Qa1 to avoid pin'
                  : _moveId == 50
                  ? 'Nb6 and the game ended in draw since the position is 0.0 according to stockfish. Perfect game play always ended in draw. Remain calm when enemy no make mistake and take opportunity when opponent do some mistake.'











                  : _moveId
              }'


              ,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}