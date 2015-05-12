require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    model_class.table_name || class_name.pluralize.underscore
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    options[:class_name] ||= name.to_s.singularize.camelcase
    options[:primary_key] ||= :id
    options[:foreign_key] ||= (name.to_s + "_id").to_sym

    options.each_pair do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    options[:class_name] ||= name.to_s.singularize.camelcase
    options[:primary_key] ||= :id
    options[:foreign_key] ||= (self_class_name.to_s.downcase + "_id").to_sym

    options.each_pair do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    assoc_options[name] = BelongsToOptions.new(name, options)
    
    define_method(name) do
      p_key = options.primary_key
      f_key = options.foreign_key
      f_key_value = send(f_key)
      options.model_class.where(p_key => f_key_value).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      p_key = options.primary_key
      f_key = options.foreign_key
      options.model_class.where(f_key => send(p_key))
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
