module Computerid

  def genseratecomputerid()
    id1 = (rand() * 100).to_i
    id2 = (rand() * 100).to_i
    id3 = (rand() * 100).to_i
    id4 = (rand() * 100).to_i

    computerid = id1.to_s + "." + id2.to_s + "." + id3.to_s + "." + id4.to_s
    cookies[:computerid] = computerid
#    return computerid
  end

  def getcomputerid()
    computerid = cookies[:computerid].nil? ? "" : cookies[:computerid]
    return computerid
  end
  
end
