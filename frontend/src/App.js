import { useEffect, useState } from 'react';

function App() {
  const [products, setProducts] = useState([]);
  const [storeName, setStoreName] = useState('Zuri Market');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const configRes = await fetch('/api/config');
        const configJson = await configRes.json();
        setStoreName(configJson.storeName || 'Zuri Market');

        const productsRes = await fetch('/api/products');
        const productsJson = await productsRes.json();
        setProducts(productsJson);
      } catch (err) {
        setError('Unable to load products.');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return (
    <div className="app-container">
      <header>
        <h1>{storeName}</h1>
        <p>Find unique Nigerian products built for the world.</p>
      </header>

      {loading && <div className="status">Loading products...</div>}
      {error && <div className="status error">{error}</div>}

      <div className="products-grid">
        {products.map(product => (
          <div key={product.id} className="product-card">
            <div className="product-image">{product.image}</div>
            <h2>{product.name}</h2>
            <p className="category">{product.category}</p>
            <p className="price">${product.price}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;
