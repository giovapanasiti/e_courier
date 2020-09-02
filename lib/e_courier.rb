require 'dotenv/load'

# or
require 'dotenv'
require "e_courier/version"

Dotenv.load


module ECourier
  class Error < StandardError; end
  # Your code goes here...
end
