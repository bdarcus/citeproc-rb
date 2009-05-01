
class Category
  attr_reader :term

  def initialize(term)
    @term = term
  end

end


class MTest
  attr_reader :categories

  def initialize()
    @categories = [Category.new('one'), Category.new('two')]
  end

  def find_by_category(category)
    @categories.select { |i| i.term == category }
  end

end

x = MTest.new()
puts x.inspect
y = x.find_by_category('two')
puts y.inspect
