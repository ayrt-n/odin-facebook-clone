require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user_with_post)
    @post = @user.posts.first
  end

  context '#liked?' do
    it 'returns false if the post has not yet been liked' do
      expect(@post.liked?).to eql(false)
    end

    it 'returns false if the post was liked and then unliked' do
      @post.likes.create(user: @user)
      @post.likes.destroy_all

      expect(@post.liked?).to eql(false)
    end

    it 'returns true if the post was liked' do
      @post.likes.create(user: @user)
      expect(@post.liked?).to eql(true)
    end
  end

  context '#liked_by?' do
    it 'returns true if the post has been liked by the user' do
      @post.likes.create(user: @user)
      expect(@post.liked_by?(@user)).to eql(true)
    end

    it 'returns false if the post has been liked by a different user' do
      other_user = FactoryBot.create(:user)
      @post.likes.create(user: other_user)
      expect(@post.liked_by?(@user)).to eql(false)
    end

    it 'returns false if the post has not been liked' do
      expect(@post.liked_by?(@user)).to eql(false)
    end
  end

  context '#edited?' do
    it 'returns true if the post has been changed since creation' do
      @post.update(body: 'Edited')
      expect(@post.edited?).to eql(true)
    end

    it 'returns false if the post has not been changed since creation' do
      expect(@post.edited?).to eql(false)
    end
  end

  context '#posted_by' do
    it 'queries all posts by the specified users' do
      @user.posts.create(body: 'Another post') # Add another post by @user to query
      second_user = FactoryBot.create(:user_with_post) # Create another user with post to query
      third_user = FactoryBot.create(:user_with_post) # Create another user with post who we don't want to query

      users = [@user, second_user] # Users we want to query posts from
      posts = @user.posts << second_user.posts # Posts we want to have queried

      expect(Post.posted_by(users)).to eq(posts)
    end
  end
end