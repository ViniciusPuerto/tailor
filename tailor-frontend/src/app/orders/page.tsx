"use client";
import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import useAuth from '@/hooks/useAuth';
import api from '@/lib/api';
import Button from '@/components/common/Button';
import Modal from '@/components/common/Modal';
import OrderForm from '@/components/orders/OrderForm';
import Link from 'next/link';

interface Order {
  id: string;
  customer_name: string;
  status: string;
  priority: string;
}

export default function OrdersPage() {
  const router = useRouter();
  const authenticated = useAuth();
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  const [open, setOpen] = useState(false);

  const fetchOrders = async () => {
    setLoading(true);
    const res = await api.get('/orders');
    setOrders(res.data.data || []);
    setLoading(false);
  };

  useEffect(() => {
    if (authenticated) {
      fetchOrders();
    }
  }, [authenticated]);

  const handleDelete = async (id: string) => {
    await api.delete(`/orders/${id}`);
    fetchOrders();
  };

  const handleLogout = () => {
    localStorage.removeItem('token');
    router.push('/login');
  };

  return (
    <div className="p-6">
      <div className="mb-4 flex items-center justify-between">
        <h1 className="text-2xl font-bold">Orders</h1>
        <div className="flex gap-2">
          <Button onClick={() => setOpen(true)}>New Order</Button>
          <Button variant="secondary" onClick={handleLogout}>Logout</Button>
        </div>
      </div>
      {authenticated === null || loading ? (
        <p>Loading...</p>
      ) : (
        <table className="min-w-full divide-y divide-gray-200">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Customer</th>
              <th className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Status</th>
              <th className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Priority</th>
              <th className="px-6 py-3"></th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-200 bg-white">
            {orders.map((o) => (
              <tr key={o.id}>
                <td className="whitespace-nowrap px-6 py-4 text-sm text-gray-900">
                  <Link href={`/orders/${o.id}`} className="text-indigo-600 hover:underline">
                    {o.customer_name}
                  </Link>
                </td>
                <td className="whitespace-nowrap px-6 py-4 text-sm text-gray-900">{o.status}</td>
                <td className="whitespace-nowrap px-6 py-4 text-sm text-gray-900">{o.priority}</td>
                <td className="whitespace-nowrap px-6 py-4 text-sm">
                  <Button variant="danger" onClick={() => handleDelete(o.id)}>
                    Delete
                  </Button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
      <Modal open={open} onClose={() => setOpen(false)} title="New Order">
        <OrderForm
          onSuccess={() => {
            setOpen(false);
            fetchOrders();
          }}
          onCancel={() => setOpen(false)}
        />
      </Modal>
    </div>
  );
} 