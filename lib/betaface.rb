require 'net/http'
require 'net/https'
require 'json'
require 'multi_json'

require 'betaface/version'
require 'betaface/util'
require 'betaface/util/client_config'
require 'betaface/rest/client'
require 'betaface/rest/errors'
require 'betaface/api'


module Betaface

  def self.key
    @key
  end

  def self.secret 
    @secret
  end

  def self.host
    @host
  end

  def self.key=(key)
    @key = key
  end

  def self.secret=(secret)
    @secret = secret
  end

  def self.host=(host)
    @host = host
  end
  
end
