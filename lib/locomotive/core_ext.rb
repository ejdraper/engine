## String
class String
  # def perma_string(sep = '_')
  #   ActiveSupport::Inflector.parameterize(self, sep).to_s
  # end

  def slugify(options = {})
    self.parameterize
  end

  def slugify!(options = {})
    replace(self.slugify(options))
  end

  def parameterize!(sep = '_')
    replace(self.parameterize(sep))
  end

end

## Hash

class Hash

  def underscore_keys
    new_hash = {}

    self.each_pair do |key, value|
      if value.respond_to?(:collect!) # Array
        value.collect do |item|
          if item.respond_to?(:each_pair) # Hash item within
            item.underscore_keys
          else
            item
          end
        end
      elsif value.respond_to?(:each_pair) # Hash
        value = value.underscore_keys
      end

      new_key = key.is_a?(String) ? key.underscore : key # only String keys

      new_hash[new_key] = value
    end

    self.replace(new_hash)
  end

end


