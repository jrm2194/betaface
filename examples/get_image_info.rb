#!/usr/bin/ruby
require 'betaface'
Betaface.key = "d45fd466-51e2-4701-8da8-04351c872236"
Betaface.secret = "171e8465-f548-401d-b63b-caf0dc28df5f"
api = Betaface::Api.new
p api.get_image_info("2bdcd1ad-47a6-45f8-ba74-86c765272422")
