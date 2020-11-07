# Chess

A fully functional chess game that can be played in a terminal.

Final assignment for the Ruby section of [The Odin Project](https://www.theodinproject.com/)

Spec and details for the assignment can be found [here](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project).

View live - [replit](https://repl.it/@HappyFrog/chess#README.md)
Solo window - [replit](https://chess.happyfrog.repl.run)

## Demo

<img src='chess_demo.gif' alt='fools mate'>

## Features

## How to use

Ruby 2.7, backwards compat 2.5, rspec 3.9, standard library only

## Style Guide

Written with the community [ruby style guide](https://rubystyle.guide/). See the .rubocop.yml file for specific tweaks.

## API tour

## Possible future additions

### User facing
* Improve UX feedback - why a move failed (invalid move, you are in check etc)
* Improve saving system (more files, custom naming)
* A Puzzle mode - mate in 3 etc
* Smarter AI

### Internal
* Various refactorings - particularly en passant, castling, and reducing size of ref and round classes
* Increase test coverage
* More unit tests
* Integration testing?


## Known Bugs

* It is possible to put yourself in check while doing an en pasasnt move, leading to an illegal board state. This will raise an exception.

## Reflections

* Biggest and most complex project
* Small things became more difficult as the project grew
* testing discipline

## Licence

## Contact
