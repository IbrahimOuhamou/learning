// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
import './App.css';
import { useState } from 'react';

export default function bismiAllah() {
  // const [menu, setMenu] = useState([Array(12).fill('la ilaha illa Allah')]);
  const [history, setHistory] = useState([Array(9).fill(null)]);

  return(
    <>
      <p>بسم الله الرحمن الرحيم</p>
    </>);
}
