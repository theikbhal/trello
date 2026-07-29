board = Board.create!(name: "Getting Started", description: "A sample board to explore")

list1 = board.lists.create!(name: "To Do", position: 1)
list2 = board.lists.create!(name: "In Progress", position: 2)
list3 = board.lists.create!(name: "Done", position: 3)

list1.cards.create!(title: "Explore the board", description: "Click around to see how it works", position: 1)
list1.cards.create!(title: "Add a new card", description: "Use the form below to add cards", position: 2)
list2.cards.create!(title: "Learning Trello clone", position: 1)
list3.cards.create!(title: "Built with Rails 8", position: 1)
