class Mat
  def media(array, already_sorted=false)
    return nil if array.empty?
    array = array.sort unless already_sorted
    m_pos = array.size / 2
    return array[m_pos]
  end
end
