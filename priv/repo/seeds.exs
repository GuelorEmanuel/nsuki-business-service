# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NsukiBusinessService.Repo.insert!(%NsukiBusinessService.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias NsukiBusinessService.Services.{Deposit, ServiceLocation}
alias NsukiBusinessService.Businesses.{Country}

no_deposit =
  %Deposit{type: "No Deposit"}
  |> NsukiBusinessService.Repo.insert!()

fixed =
  %Deposit{type: "Fixed"}
  |> NsukiBusinessService.Repo.insert!()

percentage =
  %Deposit{type: "Percentage"}
  |> NsukiBusinessService.Repo.insert!()

business_location =
  %ServiceLocation{location: "Business Location"}
  |> NsukiBusinessService.Repo.insert!()

client_location =
  %ServiceLocation{location: "Client Location"}
  |> NsukiBusinessService.Repo.insert!()

canada =
  %Country{name: "Canada"}
  |> NsukiBusinessService.Repo.insert!()

united_states =
  %Country{name: "United States"}
  |> NsukiBusinessService.Repo.insert!()

france =
  %Country{name: "France"}
  |> NsukiBusinessService.Repo.insert!()

portugal =
  %Country{name: "Portugal"}
  |> NsukiBusinessService.Repo.insert!()

netherlands =
  %Country{name: "Netherlands"}
  |> NsukiBusinessService.Repo.insert!()
