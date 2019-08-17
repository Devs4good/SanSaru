namespace :cupo do
  task :crear_tabla_de_cupo_2019, [] => [:environment] do
    Config.find_or_create_by(name: :cupo_dev_sr, value: 16)
    Config.find_or_create_by(name: :cupo_dev_jr, value: 22)
    Config.find_or_create_by(name: :cupo_ux_ui_designer, value: 10)
    Config.find_or_create_by(name: :cupo_scrum_master, value: 10)
    Config.find_or_create_by(name: :cupo_testing, value: 5)
    Config.find_or_create_by(name: :cupo_product_owner, value: 15)
  end
end