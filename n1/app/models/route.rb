# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    # buses = self
    # .buses
    # .select('driver.*')
    # #each bus on the route, who are the drivers?
    # .joins(routes.id = bus.route_id, driver.bus_id = bus.id)
    # .group(driver.id)

    buses = self.buses.includes(:drivers)

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end
end
