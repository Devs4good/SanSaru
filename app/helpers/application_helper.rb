module ApplicationHelper

  # Repetir esto en config/initializers/rails_admin.rb, en la llamada a config.main_app_name (porque es previo a esto)
  def aoc_name
    "Developers for Good"
  end

  def aoc_fullname
    "Developers for Good - 2019"
  end

  def aoc_site
    "https://www.developersforgood.com/sumate.html"
  end

  def aoc_mail
    "hola@devs4good.com"
  end

  def aoc_reserve
    "gratis"
  end

  def aoc_price
    "gratis"
  end

  def aoc_price_ideal
    "gratis"
  end

  def aoc_limit
    0
  end

  def aoc_dates
    ""
  end

  # TODO: revisar si se puede eliminar, sólo se usa en privacidad.html.erb
  def aoc_venue
    ""
  end

  # TODO: no se usa más
  def aoc_venue_location
    ""
  end

  def aoc_monkeys
    "Jorge Roldán, Lara Cabrera y Juan José Zapico"
  end
end
