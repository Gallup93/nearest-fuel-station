require 'rails_helper'

describe "user can visit the welcome page and see a dropdown menu" do
  scenario "user selects 'Turing' and searches for nearest station" do
    visit '/'
    expect(page).to have_content("Nearest Fuel Station")
    expect(page).to have_content("Search For The Nearest Electric Charging Station")
    select "Turing", from: :location
    click_on "Find Nearest Station"

    expect(current_path).to eq("/search")

    within ".station-info" do
      expect(page).to have_content("Nearest Station: Seventeenth Street Plaza")

      expect(page).to have_content("Address: 1225 17th St. Denver CO 80202")
      expect(page).to have_content("Fuel Type: ELEC")
      expect(page).to have_content("Access Times: MO: Not Specified; TU: Not Specified; WE: Not Specified; TH: Not Specified; FR: Not Specified; SA: Not Specified; SU: Not Specified")
      expect(page).to have_content("Distance: 0.1 miles")
      expect(page).to have_content("Travel Time: 00:00:40")
    end

    within ".directions" do
      expect(page).to have_content("Directions:")
      expect(page).to have_content("Start out going southeast on 17th St toward Larimer St/CO-33.")
      expect(page).to have_content("1225 17TH ST is on the right.")
    end
  end
end
