module ApplicationHelper

  def front_domain_name
    front_domain = YAML.load(File.read("#{Rails.root}/config/domain_variables.yml"))[Rails.env]
    front_domain_name = front_domain["FRONT_DOMAIN"]
  end
end
