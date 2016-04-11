module ApplicationHelper

  def style_attribute(param, value, unit: nil)
    param.to_s + ':' + value.to_s + (unit || '') + ';' unless value.nil? || value.to_s.empty?
  end

  def style_position(position, unit: nil)
    [style_attribute(:left, position.left, unit: unit),
      style_attribute(:top, position.top, unit: unit),
      style_attribute(:right, position.right, unit: unit),
      style_attribute(:bottom, position.bottom, unit: unit),
      style_attribute(:width, position.width, unit: unit),
      style_attribute(:height, position.height, unit: unit)].compact.join
  end
end
