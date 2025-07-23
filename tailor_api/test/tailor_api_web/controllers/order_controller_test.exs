defmodule TailorApiWeb.OrderControllerTest do
  use TailorApiWeb.ConnCase

  import TailorApi.OrdersFixtures

  alias TailorApi.Orders.Order

  @create_attrs %{
    priority: "some priority",
    status: "some status",
    customer_name: "some customer_name",
    customer_email: "some customer_email",
    customer_phone: "some customer_phone",
    garment_type: "some garment_type",
    fabric_type: "some fabric_type",
    fabric_color: "some fabric_color",
    measurements: "some measurements",
    special_instructions: "some special_instructions",
    fitting_notes: "some fitting_notes",
    order_date: ~D[2025-07-22],
    due_date: ~D[2025-07-22],
    delivery_date: ~D[2025-07-22],
    total_price: "120.5",
    deposit_amount: "120.5",
    balance_due: "120.5",
    payment_status: "some payment_status"
  }
  @update_attrs %{
    priority: "some updated priority",
    status: "some updated status",
    customer_name: "some updated customer_name",
    customer_email: "some updated customer_email",
    customer_phone: "some updated customer_phone",
    garment_type: "some updated garment_type",
    fabric_type: "some updated fabric_type",
    fabric_color: "some updated fabric_color",
    measurements: "some updated measurements",
    special_instructions: "some updated special_instructions",
    fitting_notes: "some updated fitting_notes",
    order_date: ~D[2025-07-23],
    due_date: ~D[2025-07-23],
    delivery_date: ~D[2025-07-23],
    total_price: "456.7",
    deposit_amount: "456.7",
    balance_due: "456.7",
    payment_status: "some updated payment_status"
  }
  @invalid_attrs %{priority: nil, status: nil, customer_name: nil, customer_email: nil, customer_phone: nil, garment_type: nil, fabric_type: nil, fabric_color: nil, measurements: nil, special_instructions: nil, fitting_notes: nil, order_date: nil, due_date: nil, delivery_date: nil, total_price: nil, deposit_amount: nil, balance_due: nil, payment_status: nil}

  setup %{conn: conn} do
    conn = conn |> put_req_header("accept", "application/json") |> auth_conn()
    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, ~p"/api/orders")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/orders", order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/orders/#{id}")

      assert %{
               "id" => ^id,
               "balance_due" => "120.5",
               "customer_email" => "some customer_email",
               "customer_name" => "some customer_name",
               "customer_phone" => "some customer_phone",
               "delivery_date" => "2025-07-22",
               "deposit_amount" => "120.5",
               "due_date" => "2025-07-22",
               "fabric_color" => "some fabric_color",
               "fabric_type" => "some fabric_type",
               "fitting_notes" => "some fitting_notes",
               "garment_type" => "some garment_type",
               "measurements" => "some measurements",
               "order_date" => "2025-07-22",
               "payment_status" => "some payment_status",
               "priority" => "some priority",
               "special_instructions" => "some special_instructions",
               "status" => "some status",
               "total_price" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/orders", order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
      conn = put(conn, ~p"/api/orders/#{order}", order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/orders/#{id}")

      assert %{
               "id" => ^id,
               "balance_due" => "456.7",
               "customer_email" => "some updated customer_email",
               "customer_name" => "some updated customer_name",
               "customer_phone" => "some updated customer_phone",
               "delivery_date" => "2025-07-23",
               "deposit_amount" => "456.7",
               "due_date" => "2025-07-23",
               "fabric_color" => "some updated fabric_color",
               "fabric_type" => "some updated fabric_type",
               "fitting_notes" => "some updated fitting_notes",
               "garment_type" => "some updated garment_type",
               "measurements" => "some updated measurements",
               "order_date" => "2025-07-23",
               "payment_status" => "some updated payment_status",
               "priority" => "some updated priority",
               "special_instructions" => "some updated special_instructions",
               "status" => "some updated status",
               "total_price" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      conn = put(conn, ~p"/api/orders/#{order}", order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, ~p"/api/orders/#{order}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/orders/#{order}")
      end
    end
  end

  defp create_order(_) do
    order = order_fixture()
    %{order: order}
  end
end
