class AddAuthorToArticle < ActiveRecord::Migration
  def change
    add_reference :articles, :author, index: true
    add_foreign_key :articles, :authors
  end
end
