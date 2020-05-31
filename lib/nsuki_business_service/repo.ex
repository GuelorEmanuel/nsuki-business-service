defmodule NsukiBusinessService.Repo do
  use Ecto.Repo,
    otp_app: :nsuki_business_service,
    adapter: Ecto.Adapters.Postgres
end
