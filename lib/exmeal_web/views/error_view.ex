defmodule ExmealWeb.ErrorView do
  use ExmealWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{result: %Changeset{} = result}) do
    %{message: translate_errors(result)}
  end

  def render("error.json", %{status: :not_found, result: result}) do
    %{message: "Meal not found"}
  end

  def render("error.json", %{result: result}) do
    %{message: result}
  end

  def render("404.json", _) do
    %{errors: %{detail: "Not Found"}}
  end

  def render("500.json", _) do
    %{errors: %{detail: "Internal Server Error"}}
  end

  def translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, result}, acc ->
        String.replace(acc, "%{#{key}}", to_string(result))
      end)
    end)
  end
end
