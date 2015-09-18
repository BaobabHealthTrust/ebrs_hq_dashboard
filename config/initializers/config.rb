CONF = YAML.load_file(Rails.root.join('config', 'couchdb.yml'))[Rails.env]
DC = YAML.load_file(Rails.root.join('config', 'dc_config.yml'))
DCDESKTOP = YAML.load_file(Rails.root.join('config', 'dc_desktop_config.yml'))
HQ = YAML.load_file(Rails.root.join('config', 'hq_config.yml'))
