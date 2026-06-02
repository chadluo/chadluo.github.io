# Liquid 4.x calls tainted? which was removed in Ruby 3.2
class Object
  def tainted?; false; end
  def untaint; self; end
end
