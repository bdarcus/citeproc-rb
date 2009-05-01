require 'rubygems'
require 'citeproc'
require 'rubydoctest'
require 'open-uri'

# doctest: Parse styles
# >> repo = CSLRepo.new('My CSL Repo', '/Users/darcusb/xbiblio/citeproc-rb/data/styles')
# doctest: Repository title
# >> repo.title()
# => 'My CSL Repo'
# doctest: Find by category
# >> bio_styles = repo.find_by_category('psychology')
# >> bio_styles.length()
# => 1
class CSLRepo

   attr_reader :title, :csl_dir

   def initialize(title, csl_dir)
     @title = title
     # a list of CSL objects
     @styles = []
     # iterate through the directory, loading the styles into the styles array
     files = Dir.entries(csl_dir)
     files.each do |style_fn|
       if style_fn.match(/(\w|-|_)*.csl/) then
         fpath = csl_dir + '/' + style_fn
         style = Citeproc::CslParser.new(fpath)
         puts "loading '" + style.style.info.title.text + "'"
         @styles << style
       end
     end
   end 
   
  
  def find_by_category(category)
    @styles.collect {|s| s.style.info.categories.select {|c| c.term == category}}
  end

  def to_atom(style_list, with_preview=True)
    style_list.each {|style| style.to_atom}
  end

end
