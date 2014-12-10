require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders vidoes in the queue" do
    comedies = Fabricate(:category)
    monk = Fabricate(:video, title: "Monk", category: comedies)
    south_park = Fabricate(:video, title: "South Park", category: comedies)
    futurama = Fabricate(:video, title: "Futurama", category: comedies)

    sign_in
    find("a[href='videos/#{monk.id}']").click
    page.should have_content(monk.title)

    click_link "+Queue"
    expect_video_in_queue(monk)

    visit video_path(monk)
    page.should_not have_content "+Queue"
    add_video_to_queue(south_park)
    add_video_to_queue(futurama)

    set_video_position(monk,3)
    set_video_position(south_park,1)
    set_video_position(futurama,2)
    update_queue

    expect_video_position(monk, "3")
    expect_video_position(south_park, "1")
    expect_video_position(futurama, "2")
    end

    def update_queue
        click_button "Update Instant Queue"
    end
    def expect_video_in_queue(video)
        page.should have_content (video.title)
    end

    def add_video_to_queue(video)
        visit videos_path
        find("a[href='videos/#{video.id}']").click
        click_link "+Queue"
    end

    def expect_video_position(video, position)
       expect(find(:xpath,"//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position) 
    end

    def set_video_position(a_new_video, a_new_position)
        within(:xpath, "//tr[contains(.,'#{a_new_video.title}')]") do
            fill_in "queue_item[][position]",with: a_new_position
        end
    end
end