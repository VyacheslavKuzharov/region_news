module Api
  module V1
    class ApiController < ApplicationController
      include ApiHelper
      include Error::ErrorHandler
    end
  end
end