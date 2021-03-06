require 'bcrypt'

class User < ActiveRecord::Base

  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates :password, :length => {:minimum => 4}, :presence => true

  has_many :ecards
  has_many :postcards

  before_save :encrypt_password
  before_save :captialize_names

  def encrypt_password
    if self.password_changed? then self.password = BCrypt::Password.create(self.password) end
  end

  def captialize_names
    self.name = self.name.split.map{|x| x.capitalize}.join(" ")
  end

  def self.get_subscriber_count
    count = User.find_all_by_subscribed(true).count;
    return count;
  end

  def self.valid_user(email, password)
    user = User.find_by_email(email)
    if !user.nil? and self.correct_password?(user, password)
      return user
    else
      return nil
    end
  end

  def self.correct_password?(user, password)
    my_password = BCrypt::Password.new(user.password)
    return my_password == password
  end

  def self.forgot_password(email)
    user = User.find_by_email(email)
    if user.nil? then return false end
    random_password = Array.new(10).map { (65 + rand(58)).chr }.join
    user.password = random_password
    user.save!
    UserMailer.password_change(user,random_password).deliver
    return true
  end

  def self.subscribed?(userId)
    return User.find(userId).subscribed
  end

  def get_recent_ecards(amount)
    #returns Array of last amount ecards
    return self.ecards.find(:all, :order => 'updated_at desc', :limit => amount)
  end

  def get_recent_postcards(amount)
    #returns Array of last amount postcards
    return self.postcards.find(:all, :order => 'updated_at desc', :limit => amount)
  end

  def can_send_postcard?
    #return boolean: true if the last card sent is older than a year 
    #or if user hasn't sent more than 2
    if self.postcards.count < 2 then return true end 
    oneYearAgo = (Date.today - 365).to_s
    oldestPostcardDate = self.postcards.find(:first, :order => 'created_at asc').created_at.to_s
    
    return oldestPostcardDate < oneYearAgo
  end

end
