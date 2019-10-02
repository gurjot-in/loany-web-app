defmodule BynkLoany.Credit.Algo do
    alias BynkLoany.Credit
    alias BynkLoany.Credit.User

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
        IO.inspect {status, result}
        IO.inspect "checking datatype"
        IO.inspect result
        IO.inspect amount
        
        cond do
            result === nil ->
                min_till_now =  find_min_from_db(amount)
                IO.inspect min_till_now
                Cachex.put(:my_cache, "current_lowest_loan_amount", min_till_now)
                {:ok}
            amount >= result ->
                IO.inspect "amount greater"
                {:ok}
            amount < result ->
                IO.inspect "amount less"
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