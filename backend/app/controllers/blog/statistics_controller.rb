class Blog::StatisticsController < Blog::BaseController
  def show
    all_posts = Post.left_joins(:comments).select("posts.id, posts.title, COUNT(comments.id) AS comment_count").group("posts.id").order("comment_count DESC")

    avg = Comment.count.to_f / [Post.count, 1].max
    paginated = all_posts.paginate(page: params[:page], per_page: 10)

    render json: {
      total_comments: Comment.count,
      popular_posts: all_posts.select { |p| p.comment_count >= avg }.map { |p| { id: p.id, title: p.title, comment_count: p.comment_count } },
      posts: paginated.map { |p| { id: p.id, title: p.title, comment_count: p.comment_count } },
      meta: {
        current_page: paginated.current_page,
        total_pages: paginated.total_pages,
        total_entries: paginated.total_entries
      }
    }
  end
end
