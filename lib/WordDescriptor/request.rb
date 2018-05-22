require 'httparty'
class WordDescriptor::Request
  include HTTParty
  include UpDupable

  def initialize(rel_jjb: nil, max_count: nil, limit: nil,
                rel_trg: nil)
    @rel_jjb = rel_jjb
    @rel_trg = rel_trg
    @max_count = max_count
  end

  def that_describe(noun)
    dup_and_update(rel_jjb: noun)
  end

  def that_are_triggered_by(word)
    dup_and_update(rel_trg: word)
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
    p = ""
    p += rel_jjb_param if @rel_jjb
    p += max_count_param if @max_count
    p += rel_trg_param if @rel_trg
    p += metadata_param
    p += ipa_param
  end

  def rel_jjb_param
    "&rel_jjb=#{@rel_jjb.gsub(/\s+/, '+')}" if @rel_jjb
  end

  def max_count_param
    "&max_count=#{@max_count}" if @max_count
  end

  def rel_trg_param
    "&rel_trg=#{@rel_trg.gsub(/\s+/, '+')}" if @rel_trg
  end

  def metadata_param
    "&md=dpsrf"
  end

  def ipa_param
    "&ipa=1"
  end
end
