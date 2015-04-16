module Computerid

  def genseratecomputerid()
    # id1 = (rand() * 100).to_i
    # id2 = (rand() * 100).to_i
    # id3 = (rand() * 100).to_i
    # id4 = (rand() * 100).to_i
# 
    # computerid = id1.to_s + "." + id2.to_s + "." + id3.to_s + "." + id4.to_s
    if !session[:computerid].to_s.include?("PART")
    count = $user_count
    computerid= "PART-#{(count + 1).to_s.rjust(3,'0')}"
  #  $user_data << {:id => $user_count, :computer_id => computerid,:status => "online" , :round => 0, :connection => "disabled" }
    session[:computerid] = computerid 
    $user_count +=1
    return computerid
  end
  end

  def getcomputerid()
   # computerid = cookies[:computerid].nil? ? "" : cookies[:computerid]
    #return computerid
  end
  
end
