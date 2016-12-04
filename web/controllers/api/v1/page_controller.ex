defmodule Themelook.Api.V1.PageController do
  use Themelook.Web, :controller
  alias Themelook.{Mailer}
  import Bamboo.Email

  def send_submit(conn, params) do
    email = new_email(
      to: "themelooksite@gmail.com",
      from: params["email"],
      subject: "Theme Submission: #{params["yourname"]} by #{params["email"]}",
      html_body: "Name: #{params["name"]}<br>Publisher: #{params["publisher"]}<br>Info Link: #{params["info"]}<br>Demo Link: #{params["demo"]}<br>
      Price: #{params["price"]}<br>Description: #{params["description"]}<br>Categories: #{params["categories"]}",
      text_body: "Name: #{params["name"]}<br>Publisher: #{params["publisher"]}<br>Info Link: #{params["info"]}<br>Demo Link: #{params["demo"]}<br>
      Price: #{params["price"]}<br>Description: #{params["description"]}<br>Categories: #{params["categories"]}"
    )
    |> Mailer.deliver_now
    render(conn, "send_submit.json", email: email)
  end
end
