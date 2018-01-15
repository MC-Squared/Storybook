class Page1AssemblyAssembly < SolidRuby::Assembly

  # Assemblies are used to show how different parts interact on your design.

  # Skip generation of the 'output' method for this assembly.
  # (will still generate 'show')
  skip :output

  view :layer1
  view :layer2
  view :layer3
  view :layer4
  view :layer5
  view :layer6
  view :layer7
  view :layer8
  view :layer9

  def position_layer(obj, layer)
    obj.translate(z: (layer-1) * $layer_z * 10)
  end

  def layer1
    res = PageLayer.new

    $page_text[0].each_with_index do |t, i|
      res -= text(text: t, size: 8, valign: "top", halign: "left")
        .linear_extrude(h: $layer_z + 0.02)
        .translate(x: -$page_x/2.0 + $page_border*1.5)
        .translate(y: $page_y/2.0 - $page_border*1.5)
        .translate(x: (i % 2) * 10, y: -15 * i, z: -0.01)
        .mirror(x: 1)
        #.color("Black")
    end

    res
  end

  def layer2
    PageLayer.new.debug
  end

  def layer3
    res = PageLayer.new

    seesaw_pin = cylinder(d: 7, h: $layer_z*4.0 + 5)

    res += seesaw_pin

    slide_track = Dovetail.new($page_y - $page_border*4.0, false)
      .translate(x: ($page_x - $page_border)/2.0 - $page_border*2.5)#, y: -($page_y - $page_border*4.0)/2.0)

    res -= slide_track
  end

  def layer4
    res = PageLayer.new.ridge

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

    res += seesaw
  end

  def layer5
    PageLayer.new.ridge
  end

  def layer6
    PageLayer.new.ridge
  end

  def layer7
    PageLayer.new.ridge
  end

  def layer8
    PageLayer.new.ridge
  end

  def layer9
    PageLayer.new.ridge
  end

  def part(show)
    res = position_layer(layer1, 1)

    res += position_layer(layer2, 2)

    res += position_layer(layer3, 3)

    res += position_layer(layer4, 4)

    res += position_layer(layer5, 5)

    res += position_layer(layer6, 6)

    res += position_layer(layer7, 7)

    res += position_layer(layer8, 8)

    res += position_layer(layer9, 9)


    # window = cube($page_x - $page_border*2.0, $page_y - $page_border*2.0, $layer_z*2 + 30)
    #   .center_xy
    #   .fillet(edges: :vertical, r: 10)
    #   .debug
    #
    # res -= position_layer(window, 6)
    #   .translate(z: -$layer_z)

    # res += cylinder(d: 40, h: $layer_z*2)
    #   .translate(y: -25, z: 30)



    slide = long_slot(h: $layer_z*2.0, d: 4, l: $page_y - $page_border*4.0)
      .rotate(z: 90)
      .translate(x: ($page_x - $page_border)/2.0 - $page_border*2.5, y: -($page_y - $page_border*4.0)/2.0)

    res += position_layer(slide, 6)

    res
  end
end
