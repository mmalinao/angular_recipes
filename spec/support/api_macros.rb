module ApiMacros
  def json_response
    JSON.parse(last_response.body)
  end

  def represent_as_json(obj, entity = obj.class::Entity)
    JSON.parse(entity.represent(obj).to_json)
  end
end
