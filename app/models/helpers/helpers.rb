class Helpers
  def self.current_user(session)
    User.find(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def slug(name)
    name.downcase.gsub(/[\'\"]/, "").gsub(/[\W]/, "-")
  end
end