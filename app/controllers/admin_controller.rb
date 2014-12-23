class AdminController < AuthenticatedUserController
  before_action :requrie_admin
end