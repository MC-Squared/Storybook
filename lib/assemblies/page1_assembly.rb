class Page1AssemblyAssembly < SolidRuby::Assembly

  # Assemblies are used to show how different parts interact on your design.

  # Skip generation of the 'output' method for this assembly.
  # (will still generate 'show')
  skip :output

  def layer(obj, layer)
    obj.translate(z: (layer-1) * $layer_z)
  end

  def part(show)
    res = layer(PageLayer.new, 1)

    res += layer(PageLayer.new
        .debug, 2)

    res += layer(PageLayer.new, 3)

    res += layer(PageLayer.new.ridge, 4)

    res += layer(PageLayer.new.ridge, 5)

    res += layer(PageLayer.new.ridge, 6)

    res += layer(PageLayer.new, 7)

    res += layer(PageLayer.new, 8)

    res += layer(PageLayer.new, 9)

    $page_text[0].each_with_index do |t, i|
      res -= text(text: t, size: 8, valign: "top", halign: "left")
        .linear_extrude(h: $layer_z + 0.02)
        .translate(x: -$page_x/2.0 + $page_border*1.5)
        .translate(y: $page_y/2.0 - $page_border*1.5)
        .translate(x: (i % 2) * 10, y: -15 * i, z: -0.01)
        .mirror(x: 1)
        #.color("Black")
    end

    window = cube($page_x - $page_border*2.0, $page_y - $page_border*2.0, $layer_z*2 + 30)
      .center_xy
      .fillet(edges: :vertical, r: 10)

    res -= layer(window, 6)
      .translate(z: -$layer_z)

    # res += cylinder(d: 40, h: $layer_z*2)
    #   .translate(y: -25, z: 30)

    seesaw = cube($page_x - $page_border*3.0, 10, $layer_z*2.0)
        .center_xy
        .fillet(edges: :vertical, r: 3)
        .rotate(z: 25)

    seesaw += cylinder(d: 12, h: $layer_z*2.0)
    seesaw -= cylinder(d: 8, h: $layer_z*2.0 + 0.02)
      .translate(z: -0.01)

    seesaw -= long_slot(h: $layer_z*2.0 + 0.02, d: 4, l: 8)
      .translate(x: $page_x/2.0 - $page_border*3.0, z: -0.01)
      .rotate(z: 25)

    res += layer(seesaw, 5)

    seesaw_pin = cylinder(d: 7, h: $layer_z*4.0 + 5)

    res += layer(seesaw_pin, 4)

    slide = long_slot(h: $layer_z*2.0, d: 4, l: $page_y - $page_border*4.0)
      .rotate(z: 90)
      .translate(x: ($page_x - $page_border)/2.0 - $page_border*2.5, y: -($page_y - $page_border*4.0)/2.0)

    #res += layer(slide, 6)

    slide_track = Dovetail.new($page_y - $page_border*4.0, false)
      .translate(x: ($page_x - $page_border)/2.0 - $page_border*2.5)#, y: -($page_y - $page_border*4.0)/2.0)

    res -= layer(slide_track, 3)
  end
end
