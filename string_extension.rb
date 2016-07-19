class String
  def strip_tabs
    gsub(/\n */, "\n").lstrip
  end
end
