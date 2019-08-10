class Role
  ALL = [
    'Dev Sr',
    'Dev Jr',
    'UX/UI Designer',
    'Scrum Master',
    'Testing',
    'Product Owner',
  ].freeze

  CONFIG_MAPPING = {
    'Dev Sr' => :cupo_dev_sr,
    'Dev Jr' => :cupo_dev_jr,
    'UX/UI Designer' => :cupo_ux_ui_designer,
    'Scrum Master' => :cupo_scrum_master,
    'Testing' => :cupo_testing,
    'Product Owner' => :cupo_product_owner,
  }.freeze

  def self.with_available_invitations
    Config.available_invitation_names.map do |invitation|
      CONFIG_MAPPING.invert[invitation.to_sym]
    end
  end
end