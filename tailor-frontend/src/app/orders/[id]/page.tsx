"use client";
import { useEffect, useState } from 'react';
import { useRouter, useParams } from 'next/navigation';
import useAuth from '@/hooks/useAuth';
import api from '@/lib/api';
import Button from '@/components/common/Button';
import Modal from '@/components/common/Modal';
import OrderForm from '@/components/orders/OrderForm';
import Link from 'next/link';

export default function OrderDetailPage() {
  useAuth();
  const router = useRouter();
  const params = useParams();
  const { id } = params as { id: string };

  const [order, setOrder] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [open, setOpen] = useState(false);

  const fetchOrder = async () => {
    setLoading(true);
    const res = await api.get(`/orders/${id}`);
    setOrder(res.data.data);
    setLoading(false);
  };

  useEffect(() => {
    if (id) fetchOrder();
  }, [id]);

  const handleDelete = async () => {
    await api.delete(`/orders/${id}`);
    router.push('/orders');
  };

  if (loading) return <p className="p-6">Loading...</p>;
  if (!order) return <p className="p-6">Not found</p>;

  return (
    <div className="p-6">
      <div className="mb-4 flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Button variant="secondary" onClick={() => router.push('/orders')}>
            Back
          </Button>
          <h1 className="text-2xl font-bold">Order #{order.id}</h1>
        </div>
        <div className="space-x-2">
          <Button variant="secondary" onClick={() => setOpen(true)}>
            Edit
          </Button>
          <Button variant="danger" onClick={handleDelete}>
            Delete
          </Button>
        </div>
      </div>
      <div className="space-y-2">
        <p>
          <strong>Customer:</strong> {order.customer_name} ({order.customer_email}, {order.customer_phone})
        </p>
        <p>
          <strong>Status:</strong> {order.status}
        </p>
        <p>
          <strong>Priority:</strong> {order.priority}
        </p>
      </div>

      <Modal open={open} onClose={() => setOpen(false)} title="Edit Order">
        <OrderForm
          initialData={order}
          onSuccess={() => {
            setOpen(false);
            fetchOrder();
          }}
          onCancel={() => setOpen(false)}
        />
      </Modal>
    </div>
  );
} 