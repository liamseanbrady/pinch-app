module Chronologicable
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def days_ago_added_less_than?(num)
      (Time.now.to_i - days_to_seconds(num)) < self.created_at.to_i
    end

    private

    def days_to_seconds(num)
      num * 24 * 60 * 60
    end 
  end
end