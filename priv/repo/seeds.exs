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

alias NsukiBusinessService.Businesses
alias NsukiBusinessService.Services


# CountryCodes
ca_us =
  %{code: 1}
  |> Businesses.create_country_code!()

fr =
  %{code: 33}
  |> Businesses.create_country_code!()

pt =
  %{code: 351}
  |> Businesses.create_country_code!()

nl =
  %{code: 31}
  |> Businesses.create_country_code!()

# Country
_canada =
  %{name: "CA"}
  |> Businesses.create_country!(ca_us)

_united_states =
  %{name: "US"}
  |> Businesses.create_country!(fr)

_portugal =
  %{name: "PT"}
  |> Businesses.create_country!(pt)

_netherlands =
  %{name: "NL"}
  |> Businesses.create_country!(nl)


# Deposit
_none =
  %{type: "NONE"}
  |> Services.create_deposit!()

_fixed =
  %{type: "FIXED"}
  |> Services.create_deposit!()

_percentage =
  %{type: "PERCENTAGE"}
  |> Services.create_deposit!()


# ServiceLocation
_atBusiness =
  %{location: "ATBUSINESS"}
  |> Services.create_service_location!()

_atClientLocation =
  %{location: "ATCLIENTLOCATION"}
  |> Services.create_service_location!()
