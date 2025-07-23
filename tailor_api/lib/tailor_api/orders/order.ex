defmodule TailorApi.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :priority, :string
    field :status, :string
    field :customer_name, :string
    field :customer_email, :string
    field :customer_phone, :string
    field :garment_type, :string
    field :fabric_type, :string
    field :fabric_color, :string
    field :measurements, :string
    field :special_instructions, :string
    field :fitting_notes, :string
    field :order_date, :date
    field :due_date, :date
    field :delivery_date, :date
    field :total_price, :decimal
    field :deposit_amount, :decimal
    field :balance_due, :decimal
    field :payment_status, :string

    belongs_to :user, TailorApi.Accounts.User
    belongs_to :created_by_user, TailorApi.Accounts.User, foreign_key: :created_by

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:customer_name, :customer_email, :customer_phone, :garment_type, :fabric_type, :fabric_color, :measurements, :special_instructions, :fitting_notes, :order_date, :due_date, :delivery_date, :status, :priority, :total_price, :deposit_amount, :balance_due, :payment_status])
    |> validate_required([:customer_name, :customer_email, :customer_phone, :garment_type, :fabric_type, :fabric_color, :measurements, :special_instructions, :fitting_notes, :order_date, :due_date, :delivery_date, :status, :priority, :total_price, :deposit_amount, :balance_due, :payment_status])
  end
end
