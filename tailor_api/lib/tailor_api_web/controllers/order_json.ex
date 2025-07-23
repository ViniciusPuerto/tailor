defmodule TailorApiWeb.OrderJSON do
  alias TailorApi.Orders.Order

  @doc """
  Renders a list of orders.
  """
  def index(%{orders: orders}) do
    %{data: for(order <- orders, do: data(order))}
  end

  @doc """
  Renders a single order.
  """
  def show(%{order: order}) do
    %{data: data(order)}
  end

  defp data(%Order{} = order) do
    %{
      id: order.id,
      customer_name: order.customer_name,
      customer_email: order.customer_email,
      customer_phone: order.customer_phone,
      garment_type: order.garment_type,
      fabric_type: order.fabric_type,
      fabric_color: order.fabric_color,
      measurements: order.measurements,
      special_instructions: order.special_instructions,
      fitting_notes: order.fitting_notes,
      order_date: order.order_date,
      due_date: order.due_date,
      delivery_date: order.delivery_date,
      status: order.status,
      priority: order.priority,
      total_price: order.total_price,
      deposit_amount: order.deposit_amount,
      balance_due: order.balance_due,
      payment_status: order.payment_status
    }
  end
end
