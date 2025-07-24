import { render, screen, waitFor } from '@testing-library/react';

// Mock useAuth to prevent router invariant errors
jest.mock('@/hooks/useAuth', () => jest.fn());

// Mock next/navigation router hooks
jest.mock('next/navigation', () => ({
  useRouter: () => ({ push: jest.fn(), replace: jest.fn() }),
}));

const mockGet = jest.fn();

jest.mock('@/lib/api', () => ({
  __esModule: true,
  default: {
    get: (...args: any[]) => mockGet(...args),
    delete: jest.fn(),
    post: jest.fn(),
    put: jest.fn(),
    interceptors: { request: { use: jest.fn() } },
  },
}));

import OrdersPage from '@/app/orders/page';

describe('OrdersPage', () => {
  it('fetches and displays orders', async () => {
    mockGet.mockResolvedValueOnce({ data: { data: [{ id: '1', customer_name: 'Alice', status: 'new', priority: 'high' }] } });

    render(<OrdersPage />);

    expect(screen.getByText(/Loading/i)).toBeInTheDocument();

    await waitFor(() => expect(screen.getByText('Alice')).toBeInTheDocument());
  });
}); 