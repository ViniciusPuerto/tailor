defmodule TailorApi.OrdersTest do
  use TailorApi.DataCase

  alias TailorApi.Orders

  describe "orders" do
    alias TailorApi.Orders.Order

    import TailorApi.OrdersFixtures

    @invalid_attrs %{priority: nil, status: nil, customer_name: nil, customer_email: nil, customer_phone: nil, garment_type: nil, fabric_type: nil, fabric_color: nil, measurements: nil, special_instructions: nil, fitting_notes: nil, order_date: nil, due_date: nil, delivery_date: nil, total_price: nil, deposit_amount: nil, balance_due: nil, payment_status: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{priority: "some priority", status: "some status", customer_name: "some customer_name", customer_email: "some customer_email", customer_phone: "some customer_phone", garment_type: "some garment_type", fabric_type: "some fabric_type", fabric_color: "some fabric_color", measurements: "some measurements", special_instructions: "some special_instructions", fitting_notes: "some fitting_notes", order_date: ~D[2025-07-22], due_date: ~D[2025-07-22], delivery_date: ~D[2025-07-22], total_price: "120.5", deposit_amount: "120.5", balance_due: "120.5", payment_status: "some payment_status"}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.priority == "some priority"
      assert order.status == "some status"
      assert order.customer_name == "some customer_name"
      assert order.customer_email == "some customer_email"
      assert order.customer_phone == "some customer_phone"
      assert order.garment_type == "some garment_type"
      assert order.fabric_type == "some fabric_type"
      assert order.fabric_color == "some fabric_color"
      assert order.measurements == "some measurements"
      assert order.special_instructions == "some special_instructions"
      assert order.fitting_notes == "some fitting_notes"
      assert order.order_date == ~D[2025-07-22]
      assert order.due_date == ~D[2025-07-22]
      assert order.delivery_date == ~D[2025-07-22]
      assert order.total_price == Decimal.new("120.5")
      assert order.deposit_amount == Decimal.new("120.5")
      assert order.balance_due == Decimal.new("120.5")
      assert order.payment_status == "some payment_status"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{priority: "some updated priority", status: "some updated status", customer_name: "some updated customer_name", customer_email: "some updated customer_email", customer_phone: "some updated customer_phone", garment_type: "some updated garment_type", fabric_type: "some updated fabric_type", fabric_color: "some updated fabric_color", measurements: "some updated measurements", special_instructions: "some updated special_instructions", fitting_notes: "some updated fitting_notes", order_date: ~D[2025-07-23], due_date: ~D[2025-07-23], delivery_date: ~D[2025-07-23], total_price: "456.7", deposit_amount: "456.7", balance_due: "456.7", payment_status: "some updated payment_status"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.priority == "some updated priority"
      assert order.status == "some updated status"
      assert order.customer_name == "some updated customer_name"
      assert order.customer_email == "some updated customer_email"
      assert order.customer_phone == "some updated customer_phone"
      assert order.garment_type == "some updated garment_type"
      assert order.fabric_type == "some updated fabric_type"
      assert order.fabric_color == "some updated fabric_color"
      assert order.measurements == "some updated measurements"
      assert order.special_instructions == "some updated special_instructions"
      assert order.fitting_notes == "some updated fitting_notes"
      assert order.order_date == ~D[2025-07-23]
      assert order.due_date == ~D[2025-07-23]
      assert order.delivery_date == ~D[2025-07-23]
      assert order.total_price == Decimal.new("456.7")
      assert order.deposit_amount == Decimal.new("456.7")
      assert order.balance_due == Decimal.new("456.7")
      assert order.payment_status == "some updated payment_status"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
