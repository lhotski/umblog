# Просто как пример сервисного класса.
class Aggregator

  def self.ips_by_logins(logins)
    posts = Post.select("posts.ip_address, string_agg(distinct users.login, ',') as logins")
        .joins(:user)
        .where(users: {login: logins})
        .group(:ip_address)

    posts.map do |post|
      post.slice(:ip_address).merge(logins: post.logins.split(','))
    end
  end
end