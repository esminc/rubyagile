require 'yaml' unless defined?(YAML)
YAML::ENGINE.yamler = 'syck' if defined?(YAML::ENGINE)
