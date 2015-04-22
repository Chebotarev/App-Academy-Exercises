def shuffle_file
  input_name = gets.chomp

  shuffled_contents = File.readlines(input_name).shuffle

  File.open("#{input_name}-shuffled.txt", "w") do |f|
    f.puts shuffled_contents
  end
end
