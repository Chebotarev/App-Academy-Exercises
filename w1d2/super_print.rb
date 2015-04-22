def super_print string, options = {}
  defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }

  options = defaults.merge(options)
  modified_string = string.dup

  modified_string.upcase! if options[:upcase]
  modified_string.reverse! if options[:reverse]
  options[:times].times { puts modified_string }
end
