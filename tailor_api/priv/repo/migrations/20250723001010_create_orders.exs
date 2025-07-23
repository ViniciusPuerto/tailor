defmodule TailorApi.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :customer_name, :string
      add :customer_email, :string
      add :customer_phone, :string
      add :garment_type, :string
      add :fabric_type, :string
      add :fabric_color, :string
      add :measurements, :text
      add :special_instructions, :text
      add :fitting_notes, :text
      add :order_date, :date
      add :due_date, :date
      add :delivery_date, :date
      add :status, :string
      add :priority, :string
      add :total_price, :decimal
      add :deposit_amount, :decimal
      add :balance_due, :decimal
      add :payment_status, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :created_by, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:orders, [:user_id])
    create index(:orders, [:created_by])
  end
end
