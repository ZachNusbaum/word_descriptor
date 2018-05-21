require 'httparty'
class WordDescriptor::Request
  include HTTParty
  include UpDupable

  def initialize(rel_jjb: nil, max_count: nil, limit: nil)
    @rel_jjb = rel_jjb
    @max_count = max_count
  end

  def that_describe(noun)
    dup_and_update(rel_jjb: noun)
  end

  def limit(max_count)
    dup_and_update(max_count: max_count)
  end

  def fetch
    response = HTTParty.get(path)
    response.parsed_response
  end

  private

  def path
    "http://api.datamuse.com/words?#{params}"
  end

  def params
    "#{rel_jjb_param}#{max_count_param}"
  end

  def rel_jjb_param
    "&rel_jjb=#{@rel_jjb.gsub(/\s+/, '+')}" if @rel_jjb
  end

  def max_count_param
    "&max_count=#{@max_count}" if @max_count
  end
end
