import 'package:flutter/material.dart';
import 'package:tetris/board.dart';

import 'values.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

  //this piece is just a list of integers
  List<int> position = [];
  //color of tetris piece
  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  //generate the integers
  void initializePiece(){
    switch(type){
      case Tetromino.L:
        position = [
          -26, 
          -16, 
          -6, 
          -5,
          ];
        break;
      case Tetromino.J:
        position = [
          -25, 
          -15, 
          -5, 
          -6,
          ];
        break;
      case Tetromino.I:
        position = [
          -4, 
          -5, 
          -6, 
          -7,
          ];
        break;
      case Tetromino.O:
        position = [
          -15, 
          -16, 
          -5, 
          -6,
          ];
        break;
      case Tetromino.S:
        position = [
          -15, 
          -14, 
          -6, 
          -5,
          ];
        break;
      case Tetromino.Z:
        position = [
          -17, 
          -16, 
          -6, 
          -5,
          ];
        break;
      case Tetromino.T:
        position = [
          -26, 
          -16, 
          -6, 
          -15,
          ];
        break;
      default: 
        
        
    }
  }

  //moving piece
  void movePiece(Direction direction){
    switch(direction){
      case Direction.left:
        for(int i=0; i<position.length; i++){
          position[i] -=1;
        }
        break;
      case Direction.right:
        for(int i=0; i<position.length; i++){
          position[i] +=1;
        }
        break;
      case Direction.down:
        for(int i=0; i<position.length; i++){
          position[i] += rowLength ;
        }
        break;
    }
  }

  // rotate piece
  int rotationState = 1;
  void rotatePiece(){
    //new position
    List<int> newPosition = [];
    
    switch(type){
        case Tetromino.L:
        switch(rotationState){
          case 0:
          /* 
          0
          0
          0 0
           */

          //get the new position
          newPosition = [
            position[1] - rowLength,
            position[1],
            position[1]  + rowLength,
            position[1] + rowLength +1,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          } 
          break;
          case 1:
          /* 
            0 0 0
            0
           */
          //assign new position
          newPosition = [
            position[1] -1,
            position[1],
            position[1] +1,
            position[1] + rowLength -1,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          }
          break;

          case 2:
          /* 
            0 0
              0
              0
           */
          //assign new position
          newPosition = [
            position[1] + rowLength,
            position[1],
            position[1] - rowLength,
            position[1] - rowLength -1,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          }
          break;
          case 3:
          /* 
                0
            0 0 0
           */
          //assign new position
          newPosition = [
            position[1] - rowLength +1,
            position[1],
            position[1]+1,
            position[1]-1,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = 0;
          }
          break;
    }
    
    break;
    case Tetromino.J:
        switch(rotationState){
          case 0:
          /* 
            0
            0
          0 0
           */

          //get the new position
          newPosition = [
            position[1] - rowLength,
            position[1],
            position[1]  + rowLength,
            position[1] + rowLength -1,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          } 
          break;
          case 1:
          /* 
            0 
            0 0 0
           */
          //assign new position
          newPosition = [
            position[1] - rowLength-1,
            position[1],
            position[1] -1,
            position[1] +1,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          }
          break;

          case 2:
          /* 
            0 0
            0
            0
           */
          //assign new position
          newPosition = [
            position[1] + rowLength,
            position[1],
            position[1] - rowLength,
            position[1] - rowLength +1,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          }
          break;
          case 3:
          /* 
            0 0 0
                0
           */
          //assign new position
          newPosition = [
            position[1] +1,
            position[1],
            position[1] -1,
            position[1] + rowLength +1,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = 0;
          }
          break;
    }
    
    break;
    case Tetromino.I:
        switch(rotationState){
          case 0:
          /* 
            0 0 0 0
           */

          //get the new position
          newPosition = [
            position[1] - 1,
            position[1],
            position[1]  + 1,
            position[1] + 2,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          } 
          break;
          case 1:
          /* 
            0 
            0 
            0
            0
           */
          //assign new position
          newPosition = [
            position[1] - rowLength,
            position[1],
            position[1] + rowLength,
            position[1] + 2*rowLength,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          }
          break;

          case 2:
          /* 
            0 0 0 0
            
           */
          //assign new position
          newPosition = [
            position[1] + 1,
            position[1],
            position[1] - 1,
            position[1] - 2,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
          }
          break;
          case 3:
          /* 
            0 
            0
            0
            0
           */
          //assign new position
          newPosition = [
            position[1] + rowLength,
            position[1],
            position[1] - rowLength,
            position[1] -2*rowLength,
          ];
          //check if new position is valid before assigning it to new position
          if (piecePositionIsValid(newPosition)) {
            //update position
            position = newPosition;
            //update rotation state
            rotationState = 0;
          }
          break;
    }
    
    break;

    case Tetromino.O:
      /*O piece does not rotate
          0 0
          0 0
      */
      break;
    case Tetromino.S:
      switch (rotationState){
        /*
          0 0
        0 0
        */
        case 0:
          newPosition = [
          position[1],
          position[1] +1,
          position[1] + rowLength -1,
          position[1] + rowLength,

        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;}
        break;
        case 1:
        /*
          0
          0 0
            0
        */
          newPosition = [
            position[0] - rowLength,
            position[0],
            position[0] +1,
            position[0] + rowLength +1,
          ];
          //check that this new position is valid move before assigning it to the real position
          if (piecePositionIsValid(newPosition)) {
            position = newPosition;
            rotationState = (rotationState + 1) % 4;}
          break;
          case 2:
          /*
            0 0
          0 0
          */
          newPosition = [
            position[1],
            position[1] +1,
            position[1] + rowLength -1,
            position[1] + rowLength,
  
          ];          //check that this new position is valid move before assigning it to the real position
          if (piecePositionIsValid(newPosition)) {
            position = newPosition;
            rotationState = (rotationState + 1) % 4;}
          break;
          case 3:
          /*
            0
            0 0
              0
          */
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] +1,
              position[0] + rowLength +1,
            ];
            //check that this new position is valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;

      }
      break;
    case Tetromino.Z:
      switch (rotationState){
        case 0:
        /* 0 0
             0 0
        */
        newPosition = [
          position[0] +rowLength -2,
          position[1],
          position[2] + rowLength -1,
          position[3] +1,
        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;}
        break;
        case 1:
        /*
            0
          0 0
          0
        */
        newPosition = [
          position[0] - rowLength +2,
          position[1],
          position[2] - rowLength +1,
          position[3] -1,
        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;}
        break;
        case 2:
        /* 0 0
             0 0
        */
        newPosition = [
          position[0] +rowLength -2,
          position[1],
          position[2] + rowLength -1,
          position[3] +1,
        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;}
        break;
        case 3:
        /*
            0
          0 0
          0
        */
        newPosition = [
          position[0] - rowLength +2,
          position[1],
          position[2] - rowLength +1,
          position[3] -1,
        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = 0;}
        break;
      }
      break;
    case Tetromino.T:
      switch(rotationState){
        case 0:
        /*
        0
        0 0 
        0
        */
        newPosition = [
          position[2] - rowLength,
          position[2],
          position[2] +1,
          position[2] + rowLength,
        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;}
        break;
        case 1:
        /*
          0 0 0
            0
            */

        newPosition = [
          position[1] -1, 
          position[1],
          position[1] +1,
          position[1] + rowLength,
        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;} 
        break;
        case 2:
        /*
            0
          0 0
            0
        */
        newPosition = [
          position[1] - rowLength,
          position[1] -1,
          position[1],
          position[1] + rowLength,
        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;}
        break;
        case 3:
        /*
            0
          0 0 0
        */
        newPosition = [
          position[2] - rowLength,
          position[2] -1,
          position[2],
          position[2] +1,
        ];
        //check that this new position is valid move before assigning it to the real position
        if (piecePositionIsValid(newPosition)) {
          position = newPosition;
          rotationState = 0;}
        break;
      }
      break;
    }

  }





//check if valid position
bool positionIsValid(int position) {
  //get the row acd col of position
  int row = (position / rowLength).floor();
  int col = position % rowLength;
  //if position is taken return false
  if (row < 0 || col < 0 || gameBoard[row][col] != null) {
    return false;
  }

  //otherwise position is valid so return true
  else {
  return true;
  }
  }

//check if piece is in valid position
  


  //check if piece can move in a direction
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for( int pos in piecePosition) {
      //return false if any position is invalid
      if (!positionIsValid(pos)) {
        return false;
      }

      //get the col of the position
      int col = pos % rowLength;
      //check if first or last col is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }

    }
    //if there is a piece in the first col and last col, it is going through the wall
    return !(firstColOccupied && lastColOccupied) ;

  }

  
}
