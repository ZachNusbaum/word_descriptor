require 'httparty'
class WordDescriptor::Request
  include HTTParty

  def initialize(path)
    @path = path
  end

  def that_describe(noun)
    self.class.new(@path + "&rel_jjb=#{noun}")
  end

  def limit(max_count)
    self.class.new(@path + "&max_count=#{max_count}")
  end

  def fetch
    response = HTTParty.get(full_path)
    response.parsed_response
  end

  private

  def full_path
    "http://api.datamuse.com#{@path}"
  end
end
