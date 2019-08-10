require 'test_helper'

class ConfigTest < ActiveSupport::TestCase
  test 'tiene invitaciones si al menos uno de los roles tiene invitaciones disponibles' do
    Config.create(name: :cupo_dev_sr, value: 0)
    Config.create(name: :cupo_dev_jr, value: 0)
    Config.create(name: :cupo_ux_ui_designer, value: 0)
    Config.create(name: :cupo_scrum_master, value: 2)
    Config.create(name: :cupo_testing, value: 0)
    Config.create(name: :cupo_product_owner, value: 0)

    assert Config.has_invitations?
  end

  test 'no tiene invitaciones si ninguno de los roles tiene invitaciones disponibles' do
    Config.create(name: :cupo_dev_sr, value: 0)
    Config.create(name: :cupo_dev_jr, value: 0)
    Config.create(name: :cupo_ux_ui_designer, value: 0)
    Config.create(name: :cupo_scrum_master, value: 0)
    Config.create(name: :cupo_testing, value: 0)
    Config.create(name: :cupo_product_owner, value: 0)

    assert_not Config.has_invitations?
  end

  test 'contar invitaciones disponibles' do
    crear_tabla_de_cupo_2019

    assert_equal Config.count_invitations, 78
  end

  test 'cupos disponibles para un determinado rol' do
    crear_tabla_de_cupo_2019

    assert_equal Config.invitations_for_role('Dev Sr'), 16
    assert_equal Config.invitations_for_role('Dev Jr'), 22
    assert_equal Config.invitations_for_role('UX/UI Designer'), 10
    assert_equal Config.invitations_for_role('Scrum Master'), 10
    assert_equal Config.invitations_for_role('Testing'), 5
    assert_equal Config.invitations_for_role('Product Owner'), 15
  end

  test 'descontar invitaciones disponibles' do
    crear_tabla_de_cupo_2019

    Config.discount_invitation(dev_senior_invitado)

    assert_equal Config.invitations_for_role('Dev Sr'), 15
    assert_equal Config.invitations_for_role('Dev Jr'), 22
    assert_equal Config.invitations_for_role('UX/UI Designer'), 10
    assert_equal Config.invitations_for_role('Scrum Master'), 10
    assert_equal Config.invitations_for_role('Testing'), 5
    assert_equal Config.invitations_for_role('Product Owner'), 15
  end

  def dev_senior_invitado
    alan_kay = User.create(
      name: 'Alan',
      lastname: 'Kay',
      email: 'alan.kay@xerox.com',
      password: 'LoveSmalltalk',
      password_confirmation: 'LoveSmalltalk',
      admin: false,
      terms_of_service: true,
      confirmed_at: Time.now,
      confirmation_token: 'alankaysmalltalk',
      confirmation_sent_at: Time.now,
    )

    alan_kay.profile = Profile.new(
      phonenumber: '1234567891',
      city: 'city',
      country: 'country',
      state: 'state',
      expectancy: 'I expect to be at least 6 smalltalk projects',
      bio: 'I did a few things related to software development.',
      role: 'Dev Sr',
    )
    alan_kay.save!
    alan_kay
  end

  def crear_tabla_de_cupo_2019
    Rake::Task["cupo:crear_tabla_de_cupo_2019"].execute
  end
end
