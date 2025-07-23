defmodule TailorApi.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TailorApi.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        balance_due: "120.5",
        customer_email: "some customer_email",
        customer_name: "some customer_name",
        customer_phone: "some customer_phone",
        delivery_date: ~D[2025-07-22],
        deposit_amount: "120.5",
        due_date: ~D[2025-07-22],
        fabric_color: "some fabric_color",
        fabric_type: "some fabric_type",
        fitting_notes: "some fitting_notes",
        garment_type: "some garment_type",
        measurements: "some measurements",
        order_date: ~D[2025-07-22],
        payment_status: "some payment_status",
        priority: "some priority",
        special_instructions: "some special_instructions",
        status: "some status",
        total_price: "120.5"
      })
      |> TailorApi.Orders.create_order()

    order
  end
end
