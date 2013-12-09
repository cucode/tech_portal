module ApplicationHelper
  ALERT_TYPES = [:error, :info, :notice, :success, :warning]

  def bootstrap_flash
    output = ""
    flash.each do |type, message|
      next if message.blank?
      next unless ALERT_TYPES.include?(type)
      type = :success if type == :notice
      type = :info if type == :alert
      type = :danger if type == :error
      output += flash_container(type, message)
    end
    raw(output)
  end

  def flash_container(type, message)
    raw(content_tag(:div, class: "alert alert-#{type}") do
      content_tag(:a, raw("&times;"), class: "close", data: { dismiss: "alert"}) +
      message
    end)
  end

  def linked_in_uri
    "http://www.linkedin.com/groups?gid=3725345&trk=myg_ugrp_ovr"
  end
end
