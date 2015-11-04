require 'spec_helper'
require 'rack/test'

class TestDeck < Syro::Deck
  include Syro::Container
end

module SpecMixin
end

RSpec.configure { |c| c.include Rack::Test::Methods }

describe Syro::Container do
  subject(:app) do
    Syro.new(TestDeck) {
      ok = Proc.new{ res.write "OK" }

      root &ok

      on('before') {
        get &ok
      }

      resolve!

      on('after') {
        get &ok
      }
    }
  end
  let(:segment) { Syro.new{ get{ res.write "OK" } } }

  it "search it's container for path segments" do
    TestDeck.register('foo1', segment)
    expect( get('/foo1') ).to be_ok
  end

  it "executes the routes provided in the block" do
    expect( get('/') ).to be_ok
    expect( get('/before') ).to be_ok
    expect( get('/after') ).to be_ok
  end

  it "fails when a segment isn't registered" do
    expect( get('/foo2').status ).to eql(404)
  end

  describe "without a block" do
    subject(:app) { Syro.new(TestDeck) }

    it "search the container for apps by default" do
      TestDeck.register('foo3', segment)
      expect( get('/foo3') ).to be_ok
    end

    it "doesn't have anything else by default" do
      expect( get('/') ).not_to be_ok
    end
  end


end
