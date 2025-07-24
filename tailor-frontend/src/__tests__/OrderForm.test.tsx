import { render, screen, fireEvent, waitFor } from '@testing-library/react';

jest.mock('@/lib/api', () => {
  const post = jest.fn().mockResolvedValue({ data: {} });
  return {
    __esModule: true,
    default: { post },
  };
});

import api from '@/lib/api';
import OrderForm from '@/components/orders/OrderForm';

describe('OrderForm', () => {
  it('submits form and calls API', async () => {
    const onSuccess = jest.fn();
    render(<OrderForm onSuccess={onSuccess} />);

    fireEvent.change(screen.getByPlaceholderText('Customer Name'), { target: { value: 'John Doe' } });

    const formElement = screen.getByRole('button', { name: /Save/i }).closest('form') as HTMLFormElement;
    fireEvent.submit(formElement);

    await waitFor(() => expect(api.post).toHaveBeenCalled());
  });
}); 