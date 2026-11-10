
import 'dart:io';

/// Stores the valid moves for the game.
List<String> validMoves = ['rock', 'paper', 'scissors'];

/// Gets a player's name and uses a default name if no name is entered.
String getPlayerName(String defaultName) {
  stdout.write('Enter $defaultName name: ');
  String? input = stdin.readLineSync();

  String playerName = (input ?? '').trim();

  return playerName.isEmpty ? defaultName : playerName;
}

/// Validates a move and returns it in lowercase.
/// Returns null if the move is invalid.
String? validateMove(String input) {
  String move = input.trim().toLowerCase();

  if (validMoves.contains(move)) {
    return move;
  }

  return null;
}

/// Asks the player to enter a move until a valid move is provided.
String getMove(String playerName) {
  String? move;

  while (move == null) {
    stdout.write(
      '$playerName, enter your move (rock/paper/scissors): ',
    );

    String? input = stdin.readLineSync();

    move = validateMove(input ?? '');

    if (move == null) {
      print('Invalid move. Please type rock, paper, or scissors.');
    }
  }

  return move;
}

/// Determines the round winner or returns null if the round is a draw.
String? decideWinner(String playerOneMove, String playerTwoMove) {
  if (playerOneMove == playerTwoMove) {
    return null;
  }

  switch (playerOneMove) {
    case 'rock':
      return playerTwoMove == 'scissors' ? 'Player 1' : 'Player 2';

    case 'paper':
      return playerTwoMove == 'rock' ? 'Player 1' : 'Player 2';

    case 'scissors':
      return playerTwoMove == 'paper' ? 'Player 1' : 'Player 2';

    default:
      return null;
  }
}

/// Prints 30 blank lines to hide Player 1's move.
void hidePlayerOneMove() {
  for (int count = 0; count < 30; count++) {
    print('');
  }
}

/// Runs the two-player Rock, Paper, Scissors game.
void main() {
  print('===== ROCK, PAPER, SCISSORS =====');

  String playerOne = getPlayerName('Player 1');
  String playerTwo = getPlayerName('Player 2');

  int playerOneScore = 0;
  int playerTwoScore = 0;
  int round = 1;

  String playAgain;

  do {
    print('\n--- Round $round ---');

    // Player 1 enters a move.
    String playerOneMove = getMove(playerOne);

    // Hide Player 1's move.
    hidePlayerOneMove();

    // Player 2 enters a move.
    String playerTwoMove = getMove(playerTwo);

    // Display both moves.
    print('\n$playerOne chose $playerOneMove.');
    print('$playerTwo chose $playerTwoMove.');

    // Determine the winner.
    String? winner = decideWinner(
      playerOneMove,
      playerTwoMove,
    );

    if (winner == null) {
      print("It's a draw!");
    } else if (winner == 'Player 1') {
      playerOneScore++;
      print('$playerOne wins the round!');
    } else {
      playerTwoScore++;
      print('$playerTwo wins the round!');
    }

    // Display current scores.
    print('\nCurrent Score:');
    print('$playerOne: $playerOneScore | $playerTwo: $playerTwoScore');

    // Ask whether the players want another round.
    stdout.write('\nPlay again? (y/n): ');
    playAgain = (stdin.readLineSync() ?? 'n').trim().toLowerCase();

    round++;
  } while (playAgain == 'y');

  // Display final scores.
  print('\n===== FINAL SCORE =====');
  print('$playerOne: $playerOneScore');
  print('$playerTwo: $playerTwoScore');

  // Announce the overall winner.
  if (playerOneScore > playerTwoScore) {
    print('Overall Winner: $playerOne!');
  } else if (playerTwoScore > playerOneScore) {
    print('Overall Winner: $playerTwo!');
  } else {
    print("Overall Result: It's a draw!");
  }

  print('\nThank you for playing!');
}
