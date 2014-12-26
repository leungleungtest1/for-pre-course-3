Fabricator(:video) do
  title {Faker::Lorem.words(5).join(" ")}
  description {Faker::Lorem.paragraph(2)}
  small_cover {Faker::Lorem.paragraph(1)}
end