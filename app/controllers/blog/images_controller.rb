class Blog::ImagesController < Blog::BaseController
  def destroy
    image = Image.find(params[:id])
    post = image.post
    image.destroy
    redirect_to edit_blog_post_path(post)
  end
end
