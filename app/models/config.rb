class Config < ApplicationRecord
  has_paper_trail
  validates :name, presence: true
  validates :value, presence: true

  ROLE_CONFIG_MAPPING = {
    'Dev Sr' => :cupo_dev_sr,
    'Dev Jr' => :cupo_dev_jr,
    'UX/UI Designer' => :cupo_ux_ui_designer,
    'Scrum Master' => :cupo_scrum_master,
    'Testing' => :cupo_testing,
    'Product Owner' => :cupo_product_owner,
  }.freeze

  def self.for_role(invited_role)
    Config.find_by(name: ROLE_CONFIG_MAPPING[invited_role])
  end

  def self.invitations_for_role(role)
    self.for_role(role)&.
      value.
      to_i
  end

  def self.has_invitations?
    count_invitations > 0
  end

  def self.count_invitations
    Config.
      where(name: [
        :cupo_dev_sr,
        :cupo_dev_jr,
        :cupo_ux_ui_designer,
        :cupo_scrum_master,
        :cupo_testing,
        :cupo_product_owner,
      ]).
      pluck(:value).
      sum(&:to_i)
  end

  def self.discount_invitation(invited)
    cupos = self.for_role(invited.profile.role)
    value = cupos&.value.to_i
    if value > 0
      value -= 1
      cupos.value = value.to_s
      cupos.save!
    else
      raise "Lo sentimos, ya no tenemos cupos disponibles :'("
    end
  end

  def self.close_invitation_period
    eleccion = Config.find_by(name: :eleccion)
    eleccion.value = 'false'
    eleccion.save!
  end

  def self.is_invitation_period_open?
    Config.find_by(name: :eleccion).value == 'true'
  end
end
