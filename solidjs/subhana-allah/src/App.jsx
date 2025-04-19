// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
import logo from './logo.svg';
import styles from './App.module.css';

function BismiAllah() {
  return (<div>
    بسم الله الرحمن الرحيم
  </div>)
}

function App() {
  return (
    <div class={styles.App}>
      <BismiAllah />
    </div>
  );
}

export default App;
