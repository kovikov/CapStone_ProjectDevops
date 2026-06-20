import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import axios from 'axios';
import App from './App.jsx';

vi.mock('axios');

test('renders store title from backend config', async () => {
  axios.get
    .mockResolvedValueOnce({ data: { storeName: 'Zuri Market' } })
    .mockResolvedValueOnce({ data: [{ id: 1, name: 'Test Product' }] });

  render(<App />);

  expect(await screen.findByRole('heading', { level: 1 })).toHaveTextContent('Zuri Market');
});
