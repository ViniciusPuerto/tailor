"use client";
import { FC, useState, FormEvent } from 'react';
import TextInput from '@/components/common/TextInput';
import Button from '@/components/common/Button';
import api from '@/lib/api';

interface OrderFormProps {
  onSuccess: () => void;
  onCancel: () => void;
  initialData?: Partial<OrderPayload>;
}

export interface OrderPayload {
  customer_name: string;
  customer_email: string;
  customer_phone: string;
  garment_type: string;
  fabric_type: string;
  fabric_color: string;
  measurements: string;
  special_instructions: string;
  fitting_notes: string;
  order_date: string;
  due_date: string;
  delivery_date: string;
  status: string;
  priority: string;
  total_price: string;
  deposit_amount: string;
  balance_due: string;
  payment_status: string;
}

const OrderForm: FC<OrderFormProps> = ({ onSuccess, onCancel, initialData }) => {
  const [form, setForm] = useState<OrderPayload>({
    customer_name: initialData?.customer_name || '',
    customer_email: initialData?.customer_email || '',
    customer_phone: initialData?.customer_phone || '',
    garment_type: initialData?.garment_type || '',
    fabric_type: initialData?.fabric_type || '',
    fabric_color: initialData?.fabric_color || '',
    measurements: initialData?.measurements || '',
    special_instructions: initialData?.special_instructions || '',
    fitting_notes: initialData?.fitting_notes || '',
    order_date: initialData?.order_date || '',
    due_date: initialData?.due_date || '',
    delivery_date: initialData?.delivery_date || '',
    status: initialData?.status || '',
    priority: initialData?.priority || '',
    total_price: initialData?.total_price || '',
    deposit_amount: initialData?.deposit_amount || '',
    balance_due: initialData?.balance_due || '',
    payment_status: initialData?.payment_status || '',
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const handleChange = (field: keyof OrderPayload) => (e: React.ChangeEvent<HTMLInputElement>) => {
    setForm({ ...form, [field]: e.target.value });
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      if (initialData && (initialData as any).id) {
        await api.put(`/orders/${(initialData as any).id}`, { order: form });
      } else {
        await api.post('/orders', { order: form });
      }
      onSuccess();
    } catch (err: any) {
      setError(err?.response?.data?.error || 'Error');
    } finally {
      setLoading(false);
    }
  };

  return (
    <form className="space-y-4" onSubmit={handleSubmit}>
      <TextInput placeholder="Customer Name" value={form.customer_name} onChange={handleChange('customer_name')} required />
      <TextInput placeholder="Customer Email" type="email" value={form.customer_email} onChange={handleChange('customer_email')} required />
      <TextInput placeholder="Customer Phone" value={form.customer_phone} onChange={handleChange('customer_phone')} required />

      <TextInput placeholder="Garment Type" value={form.garment_type} onChange={handleChange('garment_type')} required />
      <TextInput placeholder="Fabric Type" value={form.fabric_type} onChange={handleChange('fabric_type')} required />
      <TextInput placeholder="Fabric Color" value={form.fabric_color} onChange={handleChange('fabric_color')} required />
      <TextInput placeholder="Measurements" value={form.measurements} onChange={handleChange('measurements')} required />
      <TextInput placeholder="Special Instructions" value={form.special_instructions} onChange={handleChange('special_instructions')} required />
      <TextInput placeholder="Fitting Notes" value={form.fitting_notes} onChange={handleChange('fitting_notes')} required />

      <TextInput placeholder="Order Date" type="date" value={form.order_date} onChange={handleChange('order_date')} required />
      <TextInput placeholder="Due Date" type="date" value={form.due_date} onChange={handleChange('due_date')} required />
      <TextInput placeholder="Delivery Date" type="date" value={form.delivery_date} onChange={handleChange('delivery_date')} required />

      <TextInput placeholder="Total Price" type="number" step="0.01" value={form.total_price} onChange={handleChange('total_price')} required />
      <TextInput placeholder="Deposit Amount" type="number" step="0.01" value={form.deposit_amount} onChange={handleChange('deposit_amount')} required />
      <TextInput placeholder="Balance Due" type="number" step="0.01" value={form.balance_due} onChange={handleChange('balance_due')} required />

      <TextInput placeholder="Payment Status" value={form.payment_status} onChange={handleChange('payment_status')} required />

      <TextInput placeholder="Status" value={form.status} onChange={handleChange('status')} required />
      <TextInput placeholder="Priority" value={form.priority} onChange={handleChange('priority')} required />
      {error && <p className="text-red-600 text-sm">{error}</p>}
      <div className="flex justify-end gap-2">
        <Button type="submit" disabled={loading}>
          {loading ? 'Saving...' : 'Save'}
        </Button>
      </div>
    </form>
  );
};

export default OrderForm; 