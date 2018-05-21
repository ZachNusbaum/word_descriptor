require "WordDescriptor/version"
require "WordDescriptor/up_dupable"
require "WordDescriptor/request"

module WordDescriptor
  def self.words
    Request.new
  end
end
