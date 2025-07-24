import { render, screen } from '@testing-library/react';
import Button from '@/components/common/Button';

describe('Button component', () => {
  it('renders the button with provided text', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByRole('button', { name: 'Click me' })).toBeInTheDocument();
  });

  it('applies primary variant classes by default', () => {
    const { container } = render(<Button>Primary</Button>);
    expect(container.firstChild).toHaveClass('bg-indigo-600');
  });

  it('applies danger variant classes', () => {
    const { container } = render(<Button variant="danger">Danger</Button>);
    expect(container.firstChild).toHaveClass('bg-red-600');
  });
}); 