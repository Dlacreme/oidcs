defmodule OIDCS.Account do
  alias OIDCS.Account.User
  alias OIDCS.Repo
  import Ecto.Query, only: [from: 2]

  def create_user(user_attr) do
    %User{}
    |> User.changeset_sign_up(user_attr)
    |> Repo.insert()
  end

  def get_by_credentials(email, password) do
    q = from(u in User, where: u.email == ^email)

    with %User{} = user <- Repo.one(q),
         true <- Bcrypt.verify_pass(password, user.password_hash) do
      user
    else
      _ -> nil
    end
  end
end
