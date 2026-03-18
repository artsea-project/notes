#let slides = (
  "artsea-kansei-1.png",
  "artsea-kansei-2.png",
  "artsea-kansei-3.png",
  "artsea-kansei-4.png",
  "artsea-kansei-5.png",
  "artsea-kansei-6.png",
  "artsea-kansei-map-7.png",
)

#context {
  let ref-size = measure(image("artsea-kansei-1.png"))
  set page(width: ref-size.width, height: ref-size.height, margin: 0pt)

  for (i, img) in slides.enumerate() [
    #image(img, width: 100%, height: 100%, fit: "contain")
    #if i < slides.len() - 1 [
      #pagebreak()
    ]
  ]
}
