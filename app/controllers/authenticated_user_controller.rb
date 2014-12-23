class AuthenticatedUserController < ApplicationController
  before_action :require_log_in
end