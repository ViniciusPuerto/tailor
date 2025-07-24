import { render, screen } from '@testing-library/react';
import Modal from '@/components/common/Modal';

describe('Modal component', () => {
  it('does not render when open is false', () => {
    const { container } = render(<Modal open={false} onClose={() => {}}>Content</Modal>);
    expect(container.firstChild).toBeNull();
  });

  it('renders children when open is true', () => {
    render(<Modal open={true} onClose={() => {}}>Hello</Modal>);
    expect(screen.getByText('Hello')).toBeInTheDocument();
  });
}); 