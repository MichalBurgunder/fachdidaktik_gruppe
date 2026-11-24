#import "@preview/cetz:0.5.3"

/// How many copies to create in total
#let number_copies = int(sys.inputs.at("copies", default: 6))
/// How many columns should we distribute the rings over?
#let columns = int(sys.inputs.at("columns", default: 3))
/// The space reserved for the letter
#let offset = float(sys.inputs.at("offset", default: 1.5))
/// The radius until the inner line of the smaller ring
#let radius_inner = float(sys.inputs.at("radius_inner", default: 5))
/// The radius until the outer line of the bigger ring
#let radius_outer = float(sys.inputs.at(
  "radius_outer",
  default: radius_inner + 2 * offset,
))

/// Use letters or numbers, depending on the input arguments
#let use_numbers = if sys.inputs.at("use_numbers", default: "false") == "true" {
  true
} else {
  false
}

/// The alphabet that is used in the ring
#let alphabet = if use_numbers {
  range(10).map(index => str.from-unicode(
    str.to-unicode("0") + index,
  ))
} else {
  range(26).map(index => str.from-unicode(
    str.to-unicode("A") + index,
  ))
}

/// Creates a ring of letters
///
/// - `radius_inner` (float): The radius of the circle on the inner of the letters
/// - `radius_outer` (float): The radius of the circle on the outer of the letters
//  -> content
#let draw_letter_ring(radius_inner, radius_outer) = {
  // We choose a relative length of 1em to so the text fits inside the rings
  cetz.canvas(length: 1em, {
    import cetz.draw: *

    // Draw a circle in the middle as a reference where it should be cut
    circle((0, 0), radius: 0.25cm)
    // Draw the inner and outer circle
    circle((0, 0), radius: radius_inner)
    circle((0, 0), radius: radius_outer)

    // Draw the letters and the separator lines in between the circles
    for (index, letter) in alphabet.enumerate() {
      let angle_increment = -(360deg / alphabet.len())
      let angle_line = index * angle_increment
      let line_start = (angle: angle_line, radius: radius_inner)
      let line_stop = (angle: angle_line, radius: radius_outer)
      line(line_start, line_stop)
      let angle_letter = angle_line + angle_increment / 2
      let radius_middle = (radius_inner + radius_outer) / 2
      let letter_pos = (angle: angle_letter, radius: radius_middle)
      content(letter_pos, letter, angle: angle_letter - 90deg)
    }
  })
}

#set page(margin: 1cm)

#grid(
  columns: range(columns).map(it => 1fr),
  align: horizon + center,
  column-gutter: 1em,
  row-gutter: 1em,
  ..{
    let radius_middle = (radius_inner + radius_outer) / 2
    for _ in range(number_copies) {
        (
          draw_letter_ring(radius_inner, radius_middle),
          draw_letter_ring(radius_middle, radius_outer),
        )
    }
  }
)
