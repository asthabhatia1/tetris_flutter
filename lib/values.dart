 // grid dimensions
  import 'package:flutter/material.dart';

int rowLength = 10;
  int colLength = 15;


enum Direction { left, right, down, }  

enum Tetromino { 
  I, 
  J, 
  L, 
  O, 
  S, 
  T, 
  Z,
  }

  const Map<Tetromino, Color> tetrominoColors = {
    Tetromino.I: Color.fromARGB(255, 255, 39, 161),
    Tetromino.J: Color.fromARGB(255, 255, 142, 236),
    Tetromino.L: Color.fromARGB(255, 255, 100, 136),
    Tetromino.O: Color.fromARGB(255, 255, 79, 226),
    Tetromino.S: Color.fromARGB(255, 255, 151, 205),
    Tetromino.T: Color.fromARGB(255, 255, 0, 238),
    Tetromino.Z: Color.fromARGB(255, 250, 109, 170),
  };