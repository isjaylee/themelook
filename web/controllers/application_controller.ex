defmodule Themelook.Application do
  import Plug.Conn
  import Ecto.Query
  alias Themelook.{Repo, Category, Theme}

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    cat_query = from c in Category,
      where: not c.name in ["HTML", "Shopify", "Wordpress", "Opencart", "Prestashop", "WooCommerce", "Magento", "BigCommerce", "Tumblr"],
      order_by: c.name
    framework_query = from c in Category,
      where: c.name in ["HTML", "Shopify", "Wordpress", "Opencart", "Prestashop", "WooCommerce", "Magento", "BigCommerce", "Tumblr"],
      order_by: c.name
    home_categories = Repo.all(cat_query)
    frameworks = Repo.all(framework_query)
    conn
    |> assign(:home_categories, home_categories)
    |> assign(:frameworks, frameworks)
  end

end
