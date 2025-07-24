# Script for populating the database. Run with:
#
#     mix run priv/repo/seeds.exs
#
# It will create an initial admin user and a few sample orders so the
# application has data to work with in development.

alias TailorApi.{Accounts, Orders, Repo}
alias TailorApi.Orders.Order

IO.puts("==> Seeding database…")

{:ok, admin_user} =
  case Accounts.authenticate_user("admin@example.com", "supersecret") do
    {:ok, user} ->
      IO.puts("Admin user already exists. Skipping creation.")
      {:ok, user}

    :error ->
      IO.puts("Creating admin user (admin@example.com / supersecret)…")
      Accounts.register_user(%{
        email: "admin@example.com",
        password: "supersecret"
      })
  end

# Create sample orders only if none exist
if Orders.list_orders() == [] do
  IO.puts("Creating sample orders…")

  for i <- 1..5 do
    attrs = %{
      customer_name: "Customer #{i}",
      customer_email: "customer#{i}@example.com",
      customer_phone: "+1-555-000#{i}",
      garment_type: "Suit",
      fabric_type: "Wool",
      fabric_color: "Navy",
      measurements: "Chest 40, Waist 32, Inseam 30",
      special_instructions: "None",
      fitting_notes: "Fit well",
      order_date: Date.utc_today(),
      due_date: Date.add(Date.utc_today(), 30),
      delivery_date: Date.add(Date.utc_today(), 35),
      status: "in_progress",
      priority: "normal",
      total_price: Decimal.new("250.00"),
      deposit_amount: Decimal.new("100.00"),
      balance_due: Decimal.new("150.00"),
      payment_status: "partial",
      user_id: admin_user.id,
      created_by: admin_user.id
    }

    # Insert directly to bypass limited changeset casting for foreign keys
    %Order{}
    |> Order.changeset(%{
      customer_name: attrs.customer_name,
      customer_email: attrs.customer_email,
      customer_phone: attrs.customer_phone,
      garment_type: attrs.garment_type,
      fabric_type: attrs.fabric_type,
      fabric_color: attrs.fabric_color,
      measurements: attrs.measurements,
      special_instructions: attrs.special_instructions,
      fitting_notes: attrs.fitting_notes,
      order_date: attrs.order_date,
      due_date: attrs.due_date,
      delivery_date: attrs.delivery_date,
      status: attrs.status,
      priority: attrs.priority,
      total_price: attrs.total_price,
      deposit_amount: attrs.deposit_amount,
      balance_due: attrs.balance_due,
      payment_status: attrs.payment_status
    })
    |> Ecto.Changeset.apply_changes()
    |> Map.merge(%{user_id: attrs.user_id, created_by: attrs.created_by})
    |> Repo.insert!()
  end
else
  IO.puts("Sample orders already exist. Skipping creation.")
end

IO.puts("Seeding completed.")
