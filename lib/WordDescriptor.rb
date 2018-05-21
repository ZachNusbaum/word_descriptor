require "WordDescriptor/version"
require "WordDescriptor/request"

module WordDescriptor
  def self.words
    Request.new('/words?')
  end
end
