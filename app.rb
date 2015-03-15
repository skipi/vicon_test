require 'bundler'

Bundler.require
require 'vicon/controller'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

class TestController < Vicon::Controller
  def call
    context.result = context.input.to_i * 10
  end

  def validate
    context.fail!("You need to provide an input") unless context.input
  end
end

get '/:id' do
  interactor = TestController.call(input: params[:id])
  interactor.result.to_s
end
