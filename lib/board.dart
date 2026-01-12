import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

/*
GAME BOARD

this is a 2*2 grid with null representing empty spaces
a non empty space will have the color to represent the landed pieces
*/

//create game board
List<List<Tetromino?>> gameBoard = List.generate(colLength, (i)=> List.generate(rowLength, (j)=> null));
class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
 
  //curent tetris piece
Piece currentPiece = Piece(type: Tetromino.L);

//current score
int currentScore =0;

// game over status
bool gameOver = false;

@override
  void initState() {
    super.initState();
    //start the game when the app starts
    startGame();
  }


  void startGame(){
    currentPiece.initializePiece();
    
    Duration frameRate = const Duration(milliseconds: 600);
    gameLoop(frameRate);
  }

//game loop
  void gameLoop(Duration frameRate){
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          //clear lines
          clearLines();
          //check landing
          checkLanding();

          //check if game is over
          if (gameOver == true){
            timer.cancel();
            showGameOverDialog();
          }

          //move the current piece down
          currentPiece.movePiece(Direction.down);
        });
      }
      
    );
  }
  //game over message
  void showGameOverDialog(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Game Over'),
      content: Text("Your score is: $currentScore"),
      actions: [
        TextButton(onPressed: () {
          //reset the game
          Navigator.pop(context);
          resetGame();
        }, child: Text('Play Again'))
      ],
    ),);
  }

//reset game
void resetGame(){
  //clear the game board
  gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null));
//new game
gameOver = false;
currentScore =0;
//create new piece
createNewPiece();
//restart game loop
startGame();
}

//check for collisions in future positions
// return true=collision, false=no collision
bool checkCollision(Direction direction){
  //loop through easch position of the current piece
  for(int i=0; i<currentPiece.position.length; i++){
    //calculate the row and column of the current position
    int row =(currentPiece.position[i] / rowLength).floor();
    int col = currentPiece.position[i] % rowLength;

    //adjust the row and column based on the direction
    if (direction == Direction.left){
      col -=1;
    }
    else if (direction == Direction.right){
      col +=1;
    }
    else if (direction == Direction.down){
      row +=1;
    }

    //check if the peice is out of bounds
    if(col <0 || col >= rowLength || row >= colLength){
      return true;
       
    }
    // COLLISION WITH LANDED BLOCKS
    if (row >= 0 && gameBoard[row][col] != null) {
      return true;
    }
    //if no collision are detected 
   
  }
   return false;
}

void checkLanding(){
  //if going down is occupied
  if (checkCollision(Direction.down)){
    //mark position as occupied on the gameboard
    for(int i=0; i<currentPiece.position.length; i++){
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;
      if(row >=0 && row < colLength && col >=0 && col < rowLength){
        gameBoard[row][col] = currentPiece.type;
    }
    }
    //once landed create a new piece
    createNewPiece();
  }
}

void createNewPiece(){
//create a random object to select a random tetromino
  Random rand = Random();

//create a new piece with random type
  Tetromino randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
  currentPiece = Piece(type: randomType);
  currentPiece.initializePiece();
  /*
  since our game over condition is if there is a piece at the top level,
  you want to check if the game is over when you create a new piece,
  instead of checking every frame, because new pieces are allowed to go through the top level 
  but if there is already a piece in the top level when the row piece is created,
  then game is over
*/
if (isGameOver()){
  gameOver = true;
}
}


//move piece left
void moveLeft(){
  // make sure the move is valid before moving there
  if(!checkCollision(Direction.left)){
    setState(() {
      currentPiece.movePiece(Direction.left);
    });
  }
}

//move piece right
void moveRight(){
  if(!checkCollision(Direction.right)){
    setState(() {
      currentPiece.movePiece(Direction.right);
    });
  }
}


//rotate piece
void rotatePiece(){
  setState(() {
    currentPiece.rotatePiece();
  });
}


//clear lines
void clearLines(){
  //Step 1: Loop through each row of the game board from bottom to top
  for(int row = colLength -1; row >=0; row--){
    //Step 2: Initialize a variable to check if the row is full
    bool rowIsFull = true;
    //Step 3: Check if the row is full(all columns and rows are occupied)
    for(int col =0; col < rowLength; col++){
      if(gameBoard[row][col] == null){
        rowIsFull = false;
        break;
      }
    }
  
    //Step 4: if the row is full, clear it and move everything above it down
    if(rowIsFull){
      //Step 5: move all rows above the cleared row down by one position
      
      for(int r = row; r >0; r--){
        //copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r -1]);
        }
      

      //Step 6: set the top row to be empty
      gameBoard[0] = List.generate(rowLength, (index) => null);

      //step 7: increase the score
      currentScore ++;
    }
  }
}
//Game over method
bool isGameOver(){
  for (int col =0; col < rowLength; col++){
    if(gameBoard[0][col] != null){
      return true;
    }
  }
  //if the top row is empty, the game is not over
  return false;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 55, 60, 85),
      body: Column(
  children: [
    Expanded(
      child: GridView.builder(
        itemCount: rowLength * colLength,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowLength,
        ),
        itemBuilder: (context, index) {
          //get row and column from index
          int row = (index / rowLength).floor();
          int col = index % rowLength;

            if(currentPiece.position.contains(index)){
          return Pixel(color:currentPiece.color, );
            }

            //landed pieces
            else if(gameBoard[row][col] != null){
              final Tetromino? tetrominoType = gameBoard[row][col]!;
              
              return Pixel(color: tetrominoColors[tetrominoType], );

            }

            //blank pixel
            else{
              return Pixel(color: const Color.fromARGB(255, 23, 28, 51), );
            }
       }
      ),
    ),
    //score
    Text('Score: $currentScore', style: TextStyle(color: Colors.white),),
    //game controls
    Padding(
      padding: const EdgeInsets.only(bottom: 50.0, top:50),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
      
      children: [

      //left
      IconButton(onPressed: moveLeft,
      color: Colors.white,
       icon: Icon( Icons.arrow_back_ios, color: Colors.white, size: 40,)),
      //rotate 
      IconButton(onPressed: rotatePiece,
      color: Colors.white,
       icon: Icon( Icons.rotate_right, color: Colors.white, size: 40,)),
      //right
      IconButton(onPressed: moveRight,
      color: Colors.white,
       icon: Icon( Icons.arrow_forward_ios, color: Colors.white, size: 40,)),
    ],

    )
    )
  ],
),
    );
  }
}