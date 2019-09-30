defmodule BynkLoany.Credit.Algo do
    alias BynkLoany.Credit
    alias BynkLoany.Credit.User


    def are_conditions_satisfied(attrs) do

      # {:ok, var}  = Scoring.evaluate_application(112)
      {:error, 123123}
      current_changeset = User.changeset(%User{}, attrs)
      IO.inspect current_changeset
      # # IO.inspect current_changeset
      # updated_changeset = change(current_changeset, %{is_active: true})
      # apply_changes(updated_changeset)
      # IO.inspect updated_changeset
  
      # with is_valid <- changeset.valid?, 
      #      {:ok, var} <- Scoring.test()
      # do
      #   changes = changeset.changes
      #   changes["is_active"] = true
      #   changeset.changes = changes
      # else
      #   err -> err
      #   IO.inspect "error ha bsdk"
      
      #   changeset
      
  
    end
    

    def test() do
        # {:ok, 999}
        Cachex.put(:my_cache, "key", %{"one" => :two, 3 => "four", tt: 5})
        {status, result} = Cachex.get(:my_cache, "key")
        IO.inspect result[:tt]
        IO.inspect "checking prime"
        IO.inspect prime?(47)
    end

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


    # check if the application amount is larger than the smallest prev application
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
                {:error, "meri marzi haiiii"}
            
        end

    end
  
    # set the interest rate
    def calculate_interest_rate(amount) do
      if prime?(amount) do
        {:ok, 9.99}
      else
        {:ok, Enum.random(4..12)}
      end
    end
  

  end