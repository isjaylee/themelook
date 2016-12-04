defmodule Themelook.PageController do
  use Themelook.Web, :controller
  import Bamboo.Email
  alias Themelook.{Category, Mailer}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def about(conn, _params) do
    render conn, "about.html", disable_sidebar: true, disable_search_form: true
  end

  def submit_theme(conn, _params) do
    categories = Repo.all(Category)
    changeset = ContactForm.changeset(%ContactForm{})
    render(conn, "submit_theme.html", changeset: changeset, categories: categories, disable_sidebar: true, disable_search_form: true)
  end

  def terms(conn, _params) do
    render conn, "terms.html", disable_sidebar: true, disable_search_form: true
  end

  def privacy(conn, _params) do
    render conn, "privacy.html", disable_sidebar: true, disable_search_form: true
  end

  def send_submit(conn, params) do
    new_email(
      to: "themelooksite@gmail.com",
      from: params["contact_form"]["from"],
      subject: params["contact_form"]["subject"],
      html_body: params["contact_form"]["body"],
      text_body: params["contact_form"]["body"]
    )
    |> Mailer.deliver_now
    render(conn, Themelook.CategoryView, "index.html", disable_sidebar: true, disable_search_form: true)
  end
end
