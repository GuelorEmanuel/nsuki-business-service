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
alias NsukiBusinessService.Services.Deposit

no_deposit =
  %Deposit{type: "No Deposit"}
  |> NsukiBusinessService.Repo.insert!()

fixed =
  %Deposit{type: "Fixed"}
  |> NsukiBusinessService.Repo.insert!()

percentage =
  %Deposit{type: "Percentage"}
  |> NsukiBusinessService.Repo.insert!()
