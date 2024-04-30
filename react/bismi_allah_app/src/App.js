//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah
import logo from './logo.svg';
import './App.css';

let bismi_allah = {
  text: 'in the name of Allah',
  bgc: "black",
  fgc: "white",
};

function BismiAllah()
{
    return (
        <p>alhamdo li Allah</p>
    );
}

function App() {
  return (
    <div>
      <h1 className="bismi_allah">بسم الله الرحمن الرحيم</h1>
      <h1>la ilaha illa Allah mohammed rassoul Allah</h1>
      <BismiAllah />
      <p style={{ background: bismi_allah.bgc, color: bismi_allah.fgc}}>{bismi_allah.text}</p>
    </div>
  );
}

export default App;
