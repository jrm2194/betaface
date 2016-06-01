#!/usr/bin/ruby
require 'active_support/all'
require 'betaface'
Betaface.key = "d45fd466-51e2-4701-8da8-04351c872236"
Betaface.secret = "171e8465-f548-401d-b63b-caf0dc28df5f"
api = Betaface::Api.new
p api.upload_image("propoints,classifiers",{url:"http://img.wennermedia.com/480-width/1444256733_tom-cruise-zoom.jpg"})
