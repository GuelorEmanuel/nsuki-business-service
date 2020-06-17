defmodule NsukiBusinessService.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :NsukiBusinessService,
  module: NsukiBusinessService.Guardian,
  error_handler: NsukiBusinessService.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
