module WelcomeHelper

  def in_group_of_three(books)
    books.each_slice(3).to_a
  end

end
