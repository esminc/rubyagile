require 'yaml' unless defined?(YAML)
YAML::ENGINE.yamler = 'psych' if defined?(YAML::ENGINE)
