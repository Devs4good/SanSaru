class Config < ApplicationRecord
  has_paper_trail
  validates :name, presence: true
  validates :value, presence: true

  scope :invitations, -> () do
    Config.
      where(name: [
        :cupo_dev_sr,
        :cupo_dev_jr,
        :cupo_ux_ui_designer,
        :cupo_scrum_master,
        :cupo_testing,
        :cupo_product_owner,
      ])
  end

  scope :for_role, -> (invited_role) do
    Config.find_by(name: Role::CONFIG_MAPPING[invited_role])
  end

  def self.available_invitation_names
    invitations.where.not(value: '0').pluck(:name)
  end

  def self.invitations_for_role(role)
    self.for_role(role)&.value.to_i
  end

  def self.has_invitations?
    count_invitations > 0
  end

  def self.count_invitations
    invitations.pluck(:value).sum(&:to_i)
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
