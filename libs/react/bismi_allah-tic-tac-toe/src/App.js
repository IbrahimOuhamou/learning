//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
import logo from './logo.svg';
import './bismi_allah.css';
import { useState } from 'react';

export default function Board() {
  return (
    <>
      <div className="board-row">
        <Square />
        <Square />
        <Square />
      </div>
      <div className="board-row">
        <Square />
        <Square />
        <Square />
      </div>
      <div className="board-row">
        <Square />
        <Square />
        <Square />
      </div>
    </>
    )
}

//in the name of Allah
function Square() {
  const [value, setValue] = useState(null);

  function handleClick() {
    setValue('X');
  }

  return <button className="square" onClick={handleClick}>{value}</button>;
}

