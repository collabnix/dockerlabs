namespace :release do
  def branch(number)
    m = number.match(/^(\d+)\.(\d+)./)
    "v#{m[1]}.#{m[2]}"
  end

  def check_release_number(number)
    return if number =~ /^(\d)+\.(\d)+\.(\d)+$/
    puts "Version number should follow the format X.Y.Z"
    exit(-2)
  end

  desc "Prepare new release"
  task :prepare, [:number] => :environment do |_, args|
    if args.to_hash.empty?
      puts "Usage: rake release:prepare[X.Y.Z]"
      exit(-1)
    end
    number = args[:number]
    check_release_number(number)
    puts "Things you have to do to prepare the release for #{number}"
    puts "1- Create new branch #{branch(number)} if it does not exist"
    puts "2- Checkout #{branch(number)}" # TODO, what happens if it already exists?
    puts "3- Review Gemfile.lock. Review the gem versions."
    puts "4- Test and small fixes"
  end

  desc "Bump new release"
  task :bump, [:number] => :environment do |_, args|
    if args.to_hash.empty?
      puts "Usage: rake release:push[X.Y.Z]"
      exit(-1)
    end
    number = args[:number]
    check_release_number(number)
    number =~ /^(\d+)\.(\d+)./
    unless system("git checkout #{branch(number)}")
      puts "There was an error checking out #{branch(number)}. Make sure it does exists"
      exit(-3)
    end
    FileUtils.copy("CHANGELOG.md", ".CHANGELOG.md.release.rake")
    system("$EDITOR CHANGELOG.md")
    changed = FileUtils.identical?("CHANGELOG.md", ".CHANGELOG.md.release.rake")
    FileUtils.rm(".CHANGELOG.md.release.rake")
    unless changed
      answer = ""
      until ["yes", "no"].include? answer
        puts "CHANGELOG.md unchanged. Are you sure you want to continue?(yes/no)"
        answer = gets.strip
      end
      if answer != "yes"
        puts "Ok. See you later"
        exit(-4)
      end
    end
    open("VERSION", "w") do |f|
      f.write(number)
    end
    puts "Update VERSION with #{number}"
    system("git add VERSION CHANGELOG.md")
    system("git commit -m \"Bump version #{number}\"")
    system("git tag #{number} -s")
    system("git push --tags origin HEAD")
  end
end
