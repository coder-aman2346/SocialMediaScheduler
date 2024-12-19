Devise.setup do |config|
  config.omniauth :linkedin, "LINKEDIN_CLIENT_ID", "LINKEDIN_CLIENT_SECRET", scope: 'r_liteprofile rw_organization_admin w_member_social'
end