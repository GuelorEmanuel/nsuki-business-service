defmodule NsukiBusinessServiceWeb.CalendarView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.CalendarView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, CalendarView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, CalendarView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      verified: user.verified}
  end
end
