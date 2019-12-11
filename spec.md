
# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (e.g. User, Post, Category). *Wishable has three models, Users, WishList and Wish.*
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts). *A user has many wish lists and wish lists have many wishes.*
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User). *A wish list belongs to a user, and wishes belong to a wish list.*
- [x] Include user accounts with unique login attribute (username or email). *User `has_secured_password` method stores and authenticates user credentials. bcrypt gem hashes the password.*
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying. *Wish lists and wishes can be created, edited and deleted.*
- [x] Ensure that users can't modify content created by other users. *All users can see the wish lists, but only the creator of the list/wishes can create, edit or delete lists/wishes in their account. The routes verify the current user 'id` matches the wish list's `user_id` and that the wish `wish_list_id` matches the wish list `id`.*
- [ ] Include user input validations.
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code. *README includes description, usage, contributors guide, license and code of conduct.*

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
