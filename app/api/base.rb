require 'grape'
require 'active_record/validations' # otherwise, uninitialized constant ActiveRecord::RecordInvalid (NameError) thrown

class Base < Grape::API
  format :json
  default_format :json
  prefix 'api'
  version 'v1', using: :path, format: :json

  mount RecipesAPI
end
