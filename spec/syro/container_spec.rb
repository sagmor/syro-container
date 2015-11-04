require 'spec_helper'
require 'rack/test'

class TestDeck < Syro::Deck
  include Syro::Container
end

module SpecMixin
end

RSpec.configure { |c| c.include Rack::Test::Methods }

describe Syro::Container do
  subject(:app) { Syro.new(TestDeck) }
  let(:segment) { Syro.new{ get{ res.write "OK" } } }

  it "search it's container for path segments" do
    TestDeck.register('foo1', segment)

    get('foo1')

    expect(last_response).to be_ok
  end

  it "fails when a segment isn't registered" do
    get('foo2')
    expect(last_response.status).to eql(404)
  end

end
