require 'rails_helper'

RSpec.shared_examples_for 'not found' do
  it 'should return 404 status' do
    do_request
    expect(last_response.status).to eq 404
  end

  it 'should return error message' do
    do_request
    expect(json_response['error']).to eq 'Not Found'
  end
end

RSpec.shared_examples_for 'invalid params' do
  it 'should return 422 status' do
    do_request
    expect(last_response.status).to eq 422
  end

  it 'should return error message(s)' do
    do_request
    expect(json_response['error']).to_not be_nil
  end
end
