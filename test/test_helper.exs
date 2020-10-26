ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(NsukiBusinessService.Repo, :manual)
Hammox.defmock(NsukiBusinessService.MockCalendarServiceBehaviour, for: Behaviour.NsukiBusinessService.CalendarServiceBehaviour)
