task 'crear_tabla_de_cupo_2019' do
  Config.create(name: :cupo_dev_sr, value: 15)
  Config.create(name: :cupo_dev_jr, value: 22)
  Config.create(name: :cupo_ux_ui_designer, value: 10)
  Config.create(name: :cupo_scrum_master, value: 10)
  Config.create(name: :cupo_testing, value: 5)
end