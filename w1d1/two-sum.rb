class Array

    def two_sum
      answer = []
      self.each.with_index do |num1, idx1|
        self.each.with_index do |num2, idx2|

          if num1 + num2 == 0 && idx2 > idx1
            answer << [idx1, idx2]
          end
        end
      end

      answer
    end
end

p [-1,0,2,-2,1].two_sum
