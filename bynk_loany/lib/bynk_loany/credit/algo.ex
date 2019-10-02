defmodule BynkLoany.Credit.Algo do
    alias BynkLoany.Credit
    alias BynkLoany.Credit.User


    #find min loan amount from db if cache hit missed, if db empty return requested amount as lowest
    def find_min_from_db(amount) do
        IO.inspect "here in db"
        users = Credit.list_users()
        len  = length(users)
        if len > 0 do
          Enum.min(Enum.map(users, fn (x) -> x.loan_amount end))
        else
          amount   
        end

    end

    def prime?(2), do: :true
    def prime?(num) do
      last = num
              |> :math.sqrt
              |> Float.ceil
              |> trunc
      notprime = 2..last
        |> Enum.any?(fn a -> rem(num, a)==0 end)
      !notprime
    end

    
    def application_review(amount) do
      with {:ok} <- is_loan_amount_lowest(amount),
           {:ok, rate} <- calculate_interest_rate(amount) do
        {:ok, rate}
      else
        {:error, reason} -> {:error, reason}
      end
    end


    def is_loan_amount_lowest(amount) do
        {status, result} = Cachex.get(:my_cache, "current_lowest_loan_amount")
        cond do
            result === nil ->
                IO.inspect "Cache hit missed , fetching from db now"
                min_till_now =  find_min_from_db(amount)

                #update cache with the current lowest 
                Cachex.put(:my_cache, "current_lowest_loan_amount", min_till_now)
                {:ok}
            amount >= result ->
                {:ok}
            amount < result ->
                {:error, "apply with a greater loan amount"}
            
        end

    end
  
    def calculate_interest_rate(amount) do
      if prime?(amount) do
        {:ok, 9.99}
      else
        {:ok, Enum.random(4..12)}
      end
    end
  

  end