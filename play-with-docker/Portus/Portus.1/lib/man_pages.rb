require "md2man/roff/engine"

# Defines a set of methods regarding our man pages that might be re-used in
# different places.
class ManPages
  # The path were the markdown files are being stored.
  MARKDOWN_PATH = "packaging/suse/portusctl/man/markdown".freeze

  # The path were the resulting man pages are being stored.
  MAN_PATH = "packaging/suse/portusctl/man/man1".freeze

  def initialize
    @markdown_files = Dir.glob(Rails.root.join(MARKDOWN_PATH, "*.md"))
  end

  # Render the given markdown file into a man page.
  def render_markdown(file)
    Md2Man::Roff::ENGINE.render(File.read(file))
  end

  # Returns the name and the path of the corresponding man page of the given
  # markdown file.
  def corresponding_man(file)
    name = file.match(/\/([\w-]+)\.md/)[1]
    path = Rails.root.join(MAN_PATH, "#{name}.1")
    [name, path]
  end

  # Generate all the man pages.
  def generate!
    Rails.logger.info "Generating man pages:"

    @markdown_files.each do |file|
      output = render_markdown(file)
      name, path = corresponding_man(file)
      File.write path, output
      Rails.logger.info name
    end
  end
end
