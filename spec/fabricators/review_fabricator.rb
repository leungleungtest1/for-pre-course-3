Fabricator(:review) do
  rating {(1..5).to_a.sample}
  description {Faker::Lorem.paragraph}
end