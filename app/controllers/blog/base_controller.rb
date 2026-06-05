class Blog::BaseController < ApplicationController
  admin_access_only
  layout "settings"
end
