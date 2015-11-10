Given(/^the following movies exist:$/) do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end


Then(/^the director of "(.*?)" should be "(.*?)"$/) do |movie, director|
  expect(page.body).to match(/#{movie}/m)
  expect(page.find('#director').text).to match(/Director: #{director}/m)
end
