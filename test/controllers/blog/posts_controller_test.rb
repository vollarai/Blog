require "test_helper"

class Blog::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get blog_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_blog_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post blog_posts_url, params: { post: { content: @post.content, name: @post.name, title: @post.title } }
    end

    assert_redirected_to blog_post_url(Post.last)
  end

  test "should show post" do
    get blog_post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_blog_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch blog_post_url(@post), params: { post: { content: @post.content, name: @post.name, title: @post.title } }
    assert_redirected_to blog_post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete blog_post_url(@post)
    end

    assert_redirected_to blog_posts_url
  end
end
