module Version
  MAJOR = 1
  MINOR = 0
  FIX   = 0

  ALPHA = 0
  BETA  = 0
  RC    = 0
  PATCH = 0

  DATE   = '20131023'
  SPRINT = 0
  BUILD  = 1

  POST_RELEASE = false
  CODENAME = 'FP'

  def self.to_s
    return @version if @version
    @version = "v#{MAJOR}.#{MINOR}.#{FIX}#{self.postfix(:SPRINT)}#{self.postfix(:ALPHA)}#{self.postfix(:BETA)}#{self.postfix(:RC)}#{self.postfix(:PATCH)}#{self.postfix(:BUILD)}"
  end

  def self.human
    @human ||= "#{Settings.product_name} #{self.to_s}"
  end

  def self.release?(tag)
    !tag.match(/(alpha|beta|rc){1}/)
  end

  def self.plus_minus
    POST_RELEASE ? '+' : '-'
  end

  def self.postfix(type)
    @postfix ||= {}
    return @postfix[type] if @postfix[type]
    if(const_defined?(type))
      value = const_get(type)
      if value > 0
        case type
        when :PATCH
          @postfix[type] = "#{plus_minus}p.%03d" % value
        when :BUILD
          @postfix[type] = "#{plus_minus}build.#{DATE}%03d" % value
        when :SPRINT
          @postfix[type] = "#{plus_minus}s.%02d" % value
        when :RC
          @postfix[type] = "#{plus_minus}rc.%02d" % value
        else
          @postfix[type] = "#{type.to_s.downcase}.%02d" % value
        end
      end
    end
  end
end

begin
  require 'active_support/core_ext'
  require 'rails'

  module Version
    timestamp = `git log -1 --format=%ci`.strip!
    commit_id = `git log -1 --format=%h`.strip!

    if !Rails.env.production? && (!timestamp.blank? || !commit_id.blank?)
      HEAD_DETAILS = {
        commit_id: commit_id,
        timestamp: Time.parse(timestamp).utc
      }
    end

    def self.head_details
      return '' if Rails.env.production?
      @head_details ||= HEAD_DETAILS.values.join(' - ')
    end
  end

rescue LoadError
  # Do Nothing
end
