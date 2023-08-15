import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learn react link', () => {
  render(<App />);
  const linkElement = screen.getByText(/드디어 바뀐다!!!/i);
  expect(linkElement).toBeInTheDocument();
});

