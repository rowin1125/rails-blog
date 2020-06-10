module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    email_adress = user.email.downcase

    hash = Digest::MD5.hexdigest(email_adress)
    size = options[:size]
    gavatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gavatar_url, alt: user.username, class: "rounded mx-auto d-block shadow")
  end
end
