import logo from './logo.svg';
import './App.css';
import {
  BrowserRouter as Router,
  Routes,  
  Route, 
  Link
} from "react-router-dom"
import Home from './screens/Home';
import Products from './screens/Products';
import About from './screens/About';
import NotFound from './screens/NotFound';
function App() {
  return (
    <Router>
      <nav>
        <h1>This is header</h1>
        <Link to={"/"}>Home</Link> <br/>
        <Link to={"/about"}>About</Link><br />
        <Link to={"/products"}>Products</Link>        
      </nav>      
      <Routes>
        <Route path="/" element={<Home />}/>
        <Route path="/about" element={<About />}/>
        <Route path="/products/:productId" 
            element={<Products />}/>
        <Route path="*" element={<NotFound />} />
      </Routes>
      <h1>This is footer</h1>
    </Router>
  )
}

export default App;
