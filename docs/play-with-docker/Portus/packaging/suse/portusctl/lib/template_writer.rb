# Class taking care of processing the template files used by
# portusctl setup
class TemplateWriter
  # Process the given template and writes it to the final destination
  def self.process(template_name, output, context)
    t = render(template_name, context)

    File.open(output, "w") do |file|
      file.write(t)
    end
  end

  # Returns the ERB template defined inside of `template_name` using
  # the provided context
  def self.render(template_name, context)
    ERB.new(load_template(template_name), nil, "<>").result(context)
  end

  # Looks for the template inside of the default project directory and
  # then returns a string containing it.
  def self.load_template(template_name)
    t = File.join(
      File.expand_path("../../templates", __FILE__),
        template_name
    )
    File.read(t)
  end
end
