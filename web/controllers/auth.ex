defmodule Rumbl.Auth do
  import Plug.Conn
#import Comeonin.Bcrypt, only: [checkpw: 2, no_user: 0]
def init(opts) do
      Keyword.fetch!(opts, :repo)
  end
def call(conn, repo) do
      user_id = get_session(conn, :user_id)
      user = user_id && repo.get(Rumbl.User, user_id)
      assign(conn, :current_user, user)
end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

def login_by_username_and_pass(conn, username, given_pass, opts) do
  repo = Keyword.fetch!(opts, :repo)
  user = repo.get_by(Rumbl.User, username: username)
  IO.inspect "HIIIIIIIIIII"
  IO.inspect user
  cond do
    user && verify_pass(given_pass,user.password_hash) ->
      {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
        true ->
        #  no_user_verify()
          {:error, :not_found, conn}
        end
      end

    def verify_pass(password, stored_hash) do
    #  IO.inspect "HIIIIIIIIIIII"
    #IO.inspect :binary.bin_to_list(stored_hash)
    if(password==stored_hash) do
        true
      else
        false
    end

      #check_pass(:binary.bin_to_list(password), :binary.bin_to_list(stored_hash))

 end

defp check_pass(s1,s2)do
  if(s1==s2) do
    handle_verify(0)
  else
    handle_verify(1)
  end
end
 defp handle_verify(0) do
   true
 end
 defp handle_verify(_)do
   false
 end

 def logout(conn) do
configure_session(conn, drop: true)
end
This 

end
