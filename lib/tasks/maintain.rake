namespace :maintain do
  task :fix_tags => :environment do

    Listing.all.each do |l|
      new_tags = []
      if l.tag_list.join(",").include? ' '
        l.tag_list.each do |t|
          tags = t.split(' ')
          new_tags << tags
          if tags.length > 1
            tags.each do |word|
              tag = ActsAsTaggableOn::Tag.where(:name=>word).first
              if tag.present? && !l.tag_list.include?(word)
                l.tags << tag
              end
            end
            ActsAsTaggableOn::Tag.find_by_name(t).destroy
          end
        end
        l.update_attribute(:tag_list, :new_tags)
      end
    end
  end


  task :assign_listings_to_admin => :environment do
    Listing.all.each do |lis|
      if lis.user.present?
      else
        lis.update_attribute(:user_id, 1)
      end
    end
  end
end
