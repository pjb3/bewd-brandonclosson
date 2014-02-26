TAX_RATE = 1.05

def calculate_total(*items)
  total = 0

  items.each do |item|
    total += ((item[:quantity] * item[:price]) * TAX_RATE)
  end

  "$%.2f" % total
end