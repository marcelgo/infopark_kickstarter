atom_feed :language => 'en-US' do |feed|
  feed.title "Blog Entries"
  feed.updated Time.now

  @entries.each do |item|
    feed.entry( item ) do |entry|
      entry.title item.title

      # the strftime is needed to work with Google Reader.
      entry.updated(Time.now.strftime("%Y-%m-%dT%H:%M:%SZ"))
      entry.author do |author|
        author.name "#{item.author.try(:first_name)} #{item.author.try(:last_name)}"
        author.email item.author.try(:email) || ''
      end
    end
  end
end