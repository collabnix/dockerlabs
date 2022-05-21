# Version module
# Makes the app version available to the application itself
# Needs the git executable for all git operations
module Version
  # Returns true if the version can be extracted by using git, false
  # otherwise.
  def self.git?
    # Check that the ".git" directory at least exists.
    return false unless File.exist?(Rails.root.join(".git"))

    # Check whether we have git in our system.
    paths = ENV["PATH"].split(":")
    paths.each { |p| return true if File.executable?(File.join(p, "git")) }
    false
  end

  COMMIT = Version.git? ? `git log --pretty=format:'%h' -n 1 2>/dev/null`.chomp : nil
  TAG    = Version.git? ? `git tag --points-at $(git rev-parse HEAD) 2>/dev/null`.chomp : nil
  BRANCH = if Version.git?
    `git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3 2>/dev/null`.chomp
  end

  # Version.value returns the app version
  # Priority: git tag > git branch/commit > VERSION file
  def self.value
    if TAG.present?
      TAG.to_s
    elsif COMMIT.present?
      if BRANCH.present?
        "#{BRANCH}@#{COMMIT}"
      else
        COMMIT.to_s
      end
    else
      version = Rails.root.join("VERSION")
      File.read(version).chomp if File.exist?(version)
    end
  end
end
