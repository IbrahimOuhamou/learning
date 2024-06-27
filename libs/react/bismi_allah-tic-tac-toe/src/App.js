//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah

import './bismi_allah.css';
import { useState } from 'react';

export default function Game() {
  const [history, setHistory] = useState([Array(9).fill(null)]);
  const [currentMove, setCurrentMove] = useState(0);
  const currentSquares = history[currentMove];
  const xIsNext = currentMove % 2 === 0;

  function handlePlay(nextSquares) {
    const nextHistory = [...history.slice(0, currentMove + 1), nextSquares];
    setHistory(nextHistory);
    setCurrentMove(nextHistory.length - 1);
  }

  function jumpTo(nextMove) {
    setCurrentMove(nextMove);
  }

  const moves = history.map((squares, move) => {
    if(move === history.length - 1) {
      return <li> you are at move {move} </li>
    }

    let description;
    if (move > 0 && move < history.length - 1) {
      description = 'Go to move #' + move;
    } else {
      description = 'Go to start';
    }

    return (
      <li key={move}> 
        <button onClick={() => jumpTo(move)}>{description}</button>
      </li>
    )
  })

  return (
    <div className="game">
      <div className="game-board">
        <Board xIsNext={xIsNext} squares={currentSquares} onPlay={handlePlay} />
      </div>
      <div className="game-info">
        <ol>
          <li>بسم الله الرحمن الرحيم</li>
          {moves}
        </ol>
      </div>
    </div>
  )
}

function Board({xIsNext, squares, onPlay}) {

  function handleClick(i) {
    if(squares[i] || calculateWinner(squares)) return;

    const nextSquares = squares.slice();
    nextSquares[i] = xIsNext ? 'X' : 'O';

    onPlay(nextSquares);
  }

  const winner = calculateWinner(squares);
  let status;

  if (winner) {
    status = 'Winner: ' + winner;
  } else {
    status = 'Next player: ' + (xIsNext ? 'X' : 'O')
  }

  let rows = [];
  for (let i = 0; i < 3; i++) {
    let row_squares = [];
    for (let j = i; j < i + 3; j++) {
      row_squares[j] = <Square value={squares[j]} onSquareClick={() => handleClick(j)}></Square>
    }

    rows[i] = <div className="board-row"> {row_squares} </div>
  }

  return (
    <>
      <div className="status">{status}</div>
      {rows}
    </>
    )
}

function calculateWinner(squares) {
  const lines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  for (let i = 0; i < lines.length; i++) {
    const [a, b, c] = lines[i];
    if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
      return squares[a];
    }
  }

  return null;
}

//in the name of Allah
function Square({value, onSquareClick}) {
  return (
    <button className="square" onClick={onSquareClick}>
      {value}
    </button>
  );
}

