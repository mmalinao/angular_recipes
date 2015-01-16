require 'grape'
require 'active_record/validations' # otherwise, uninitialized constant ActiveRecord::RecordInvalid (NameError) thrown

class Base < Grape::API
  format :json
  default_format :json
  prefix 'api'
  version 'v1', using: :path, format: :json

  rescue_from ActiveRecord::RecordNotFound do |e|
    error_response message: 'Not Found', status: 404
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error_response message: e.message, status: 422
  end

  mount RecipesAPI
end
