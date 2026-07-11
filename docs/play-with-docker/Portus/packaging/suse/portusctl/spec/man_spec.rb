require_relative "spec_helper"
require "man_pages"

# Returns the path of the given markdown file.
def md_path(name)
  Rails.root.join(ManPages::MARKDOWN_PATH, name + ".md")
end

# Returns the first line of the given markdown document.
def header(name)
  output = File.open(md_path(name), &:readline)
  output.strip
end

# Returns true if the given file contents the given section.
def section_in_file(section, name)
  File.read(md_path(name)) =~ /# #{section}/
end

# Returns the names of all the commands prefixed with "portusctl-" and the main
# file.
def names(main = true)
  files = (Cli.commands.keys << "help").map { |c| "portusctl-" + c.tr("_", "-") }
  return files unless main
  files << "portusctl"
end

describe ManPages do
  it "describes all the available commands" do
    names.each { |c| expect(File.exist?(md_path(c))).to be_truthy }
  end

  it "contains the right header/footer" do
    h = 'PORTUSCTL 1 "portusctl User manuals" "SUSE LLC." "AUGUST 2016"'
    names.each { |f| expect(header(f)).to eq(h) }
  end

  it "is up-to-date md to man" do
    mp = ManPages.new

    names.each do |n|
      got = mp.render_markdown(md_path(n))
      _, man = mp.corresponding_man(md_path(n).to_s)
      expected = File.read(man)

      expect(got).to eq expected
    end
  end

  it "contains all the required sections" do
    common = ["NAME", "SYNOPSIS", "DESCRIPTION", "HISTORY"]

    (common + ["COMMANDS", "EXAMPLES"]).each do |section|
      expect(section_in_file(section, "portusctl")).to be_truthy
    end

    names(false).each do |n|
      sections =
        if n == "portusctl-logs" || n == "portusctl-help" || n == "portusctl-make-admin"
          common
        elsif n == "portusctl-setup"
          common + ["OPTIONS", "EXAMPLES"]
        else
          common + ["EXAMPLES"]
        end

      sections.each { |s| expect(section_in_file(s, n)).to be_truthy }
    end
  end

  it "contains all the available options" do
    Cli.commands.each do |command|
      path = md_path("portusctl-" + command.first.tr("_", "-"))

      command.last["options"].keys.each do |opt|
        exists = File.read(path) =~ /\*\*--#{opt}\*\*/
        expect(exists).to be_truthy
      end
    end
  end
end
