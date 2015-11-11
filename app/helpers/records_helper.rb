module RecordsHelper
  def precision(n)
    n.is_a?(Integer) ? 0 : 1
  end
end
