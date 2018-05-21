module UpDupable
  def dup_and_update(**args)
    self.class.new(clean_ivars.merge(args))
  end

  private

  def clean_ivars
    instance_variables_get.each_with_object({}) do |(k, v), hash|
      hash[k.to_s.gsub('@', '').to_sym] = v
    end
  end

  def instance_variables_get
    instance_variables.each_with_object({}) do |ivar, hash|
      hash[ivar] = instance_variable_get(ivar)
    end
  end
end
