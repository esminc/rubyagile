class Image < ActiveRecord::Base
  # has_attachment(:thumbnails => { :thumb => '120x' })
  belongs_to :article

  def filepath
    "/images/#{id}.#{extension}"
  end

  private
  def extension
    filename.split('.').last
  end
end
