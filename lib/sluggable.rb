module Sluggable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      class_level_setup
    end
  end

  module InstanceMethods
    def to_param
      self.slug
    end

    def generate_slug!
      possible_slug = to_slug(self.send(self.class.slug_column.to_sym))
      ar_obj = self.class.find_by(slug: possible_slug)

      uniq_id = 2

      while ar_obj && ar_obj != self
        possible_slug = append_suffix(possible_slug, uniq_id)
        ar_obj = self.class.find_by(slug: possible_slug)
        uniq_id += 1
      end

      self.slug = possible_slug
    end

    private

    def to_slug(str)
      str = str.strip
      str.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
      str.gsub!(/-+/, '-')
      str.downcase
    end

    def append_suffix(slug, id)
      if slug.split('-').last.to_i != 0
        slug = slug.split('-').slice(0...-1).join('-')
      end

      "#{slug}-#{id}"
    end
  end

  module ClassMethods
    def class_level_setup
      before_save :generate_slug!
      class_attribute :slug_column
    end

    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end

