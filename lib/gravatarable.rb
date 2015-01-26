module Gravatarable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      call_class_methods
    end
  end

  module InstanceMethods
    def gravatar_url
      email = self.send(self.class.email_addr.to_sym)
      gravatar_path(hash_email(email))
    end

    private

    def gravatar_path(hsh)
      "http://www.gravatar.com/avatar/#{hsh}"
    end

    def hash_email(email)
      Digest::MD5.hexdigest(email)
    end
  end

  module ClassMethods
    def call_class_methods
      class_attribute :email_addr
    end

    def gravatar_column(col_name)
      self.email_addr = col_name
    end
  end
end