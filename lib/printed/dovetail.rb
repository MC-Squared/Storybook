require_relative 'params'

class Dovetail < SolidRuby::Printed
  def initialize(l=1, inner=true)
    @length = l
    @inner = inner
  end

  def part(_show)
    h = $dovetail_h
    w = $dovetail_w

    unless @inner
      h += $tolerance
      w += $tolerance
    end

    res = cube(w, @length, h)
      .center_xy

    res -= cube(w, @length + 5, w)
      .center_y
      .translate(x: $dovetail_w/10.0)
      .rotate(y: 45)

    res -= cube(w, @length + 5, w)
      .center_y
      .translate(x: $dovetail_w/10.0)
      .rotate(y: 45)
      .mirror(x: 1)

    res.rotate(x: 180)
      .translate(z: h)
      .color("BLUE")
  end
end
