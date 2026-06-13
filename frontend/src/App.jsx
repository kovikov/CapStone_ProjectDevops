import { useEffect, useState } from "react";
import axios from "axios";
import "./App.css";

const API_URL = "/api";

function App() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    axios
      .get(`${API_URL}/api/products`)
      .then((response) => setProducts(response.data))
      .catch((error) => console.error("Error fetching products:", error));
  }, []);

  return (
    <main>
      <h1>{import.meta.env.VITE_STORE_NAME || "Zuri Market"}</h1>
      <p>African artisan products for customers across Europe.</p>

      <div className="products">
        {products.map((product) => (
          <div key={product.id} className="card">
            <h2>{product.name}</h2>
            <p>{product.category}</p>
            <p>£{product.price}</p>
          </div>
        ))}
      </div>
    </main>
  );
}

export default App;
