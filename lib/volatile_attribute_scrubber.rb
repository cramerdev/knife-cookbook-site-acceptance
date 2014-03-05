class VolatileAttributeScrubber

  def scrub(content)
    volatile_attribute_line = /^created_at|updated_at|file|tarball_file_size/

    content.strip.lines.reject do |line|
      line.match(volatile_attribute_line)
    end.join("\n")
  end

end
