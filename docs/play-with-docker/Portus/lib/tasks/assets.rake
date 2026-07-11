# Tasks taken from Gitlab's yarn.rake and assets.rake files.

namespace :portus do
  namespace :yarn do
    desc "Ensure Yarn is installed"
    task :available do
      unless system("yarn --version", out: File::NULL)
        warn(
          "Error: Yarn executable was not detected in the system.".color(:red),
          "Download Yarn at https://yarnpkg.com/en/docs/install".color(:green)
        )
        abort
      end
    end

    desc "Ensure Node dependencies are installed"
    task check: ["yarn:available"] do
      cmd = "yarn check --ignore-engines"
      cmd += " --offline" if ENV["PACKAGING"] == "yes"

      unless system(cmd, out: File::NULL)
        warn(
          "Error: You have unmet dependencies. (`yarn check` command failed)".color(:red),
          "Run `yarn install` to install missing modules.".color(:green)
        )
        abort
      end
    end
  end

  namespace :assets do
    desc "Compile all frontend assets"
    task compile: [
      "assets:precompile",
      "webpack:compile"
    ]
  end
end
