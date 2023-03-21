require_relative "serializer"

module Oscal
  class MemberOfOrganization
    include Serializer

    KEY = %i(val)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? MemberOfOrganization
      return MemberOfOrganization.new(obj) unless obj.is_a? Array

      obj.map do |x|
        MemberOfOrganization.wrap(x)
      end
    end

    def initialize(options={})
      unless options.is_a? Hash
        options = {'val' => options}
      end

      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in MemberOfOrganization")
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end