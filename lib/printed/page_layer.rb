require_relative 'params'

#Basic class for a single layer of a page.
#A single page is made up of 2 or more PageLayers (for colour changing)
#And optionally a ridge around the edge
class PageLayer < SolidRuby::Printed
  def initialize
  end

  def part(_show)
    #we use different fillets on right vs left sides
    # to give a clearer indication of right-to-left
    page
  end

  def page(border=0, height=$layer_z)
    res = cube(x: $page_x/2.0 - border/2.0, y: $page_y - border, z: height)
      .fillet(right: [:left, :right], r: 10)
      .translate(x: $page_x/2.0 - 0.01)

    res += cube(x: $page_x/2.0 - border/2.0, y: $page_y - border, z: height)
      .fillet(left: [:left, :right], r: 5)
      .translate(x: border/2.0)

    res.translate(x: -$page_x/2.0, y: -$page_y/2.0 + border/2.0)
  end

  def ridge
    res = page(0)

    res -= page($page_border, $layer_z*2.0)
      .translate(z: -$layer_z*0.5)
  end
end
