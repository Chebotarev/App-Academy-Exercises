require 'byebug'

class Array
  def my_each(&prc)
    i = 0
    while i < self.length do
      prc.call(self[i])
      i +=1
    end
  end

  def my_map(&prc)
    result = []
    self.my_each do |el|
      result << prc.call(el)
    end

    result
  end

  def my_select(&prc)
    result = []
    self.my_each do |el|
      if prc.call(el)
        result << el
      end
    end
    result
  end


  def my_inject(&prc)
    #prc.call(arg1, arg2)
    result = create_empty(self[0])

    self.my_each do |el|
      result = prc.call(result, el)
    end
    result
  end

  def my_sort!(&prc)
    prc ||= proc { |num1, num2| 1 }
    sorted = false
    until sorted
      sorted = true
      self.each_index do |i|
        next if self[i + 1].nil?
        if prc.call(self[i], self[i+1]) == 1
          sorted = false
          self[i], self[i + 1] = self[i + 1], self[i]
        end
      end
    end
    self
  end

  private

      def create_empty(object)
        object.is_a?(Fixnum) ? 0 : object.class.new
      end
end



def eval_block(*args, &prc)
   unless block_given?
     return "NO BLOCK GIVEN"
   end
  prc.call(*args)
end


eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end
# Washington, Kerry won 23 votes.
# => nil

x = eval_block(1,2,3,4,5) do |*args|
  args.inject(:+)
end
p x
# => 15

p eval_block(1, 2, 3)




# # p ["1", "2", "3"].my_inject { |sum, el| sum + el }
# p [2, 1, 3, 7, 5].my_sort! { |num1, num2| num1 <=> num2 }
