import express from "express";
import cors from "cors";
import "dotenv/config";

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

const products = [
  {
    id: 1,
    name: "Ankara Tote Bag",
    category: "Fashion",
    price: 35,
    image: "ankara-bag.jpg"
  },
  {
    id: 2,
    name: "Organic Shea Butter",
    category: "Skincare",
    price: 18,
    image: "shea-butter.jpg"
  },
  {
    id: 3,
    name: "Handcrafted Bead Necklace",
    category: "Jewellery",
    price: 25,
    image: "bead-necklace.jpg"
  }
];

app.get("/", (req, res) => {
  res.json({
    message: "Zuri Market Backend API is running"
  });
});

app.get("/api/products", (req, res) => {
  res.json(products);
});

app.get("/api/config", (req, res) => {
  res.json({
    storeName: process.env.STORE_NAME || "Zuri Market"
  });
});

if (process.argv[1] === new URL(import.meta.url).pathname) {
  app.listen(PORT, () => {
    console.log(`Backend running on port ${PORT}`);
  });
}

export default app;
