class Array

  def my_uniq
    unique = []
    self.each do |element|
        unless unique.include?(element)
          unique << element
        end
    end
    unique
  end
end

p [23,3,4,5,4,23].my_uniq
