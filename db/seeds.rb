# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

movies = [
  {
    title: 'Drive',
    description: <<-TXT
      Drive is a 2011 American action drama film directed by Danish filmmaker
      Nicolas Winding Refn. The screenplay, written by Hossein Amini, is based on
      James Sallis\' 2005 novel Drive. The film stars Ryan Gosling as an unnamed
      Hollywood stunt driver who moonlights as a getaway driver.
      He quickly grows fond of his neighbor, Irene (Carey Mulligan),
      and her young son, Benicio. When her debt-ridden husband,
      Standard (Oscar Isaac), is released from prison, the two men take part in
      what turns out to be a botched million-dollar heist that endangers the
      lives of everyone involved. Bryan Cranston, Christina Hendricks,
      Ron Perlman, and Albert Brooks play supporting roles.'
    TXT
  },
  {
    title: '1408',
    description: <<-TXT
      1408 is a 2007 American psychological horror thriller film based on
      Stephen King's 1999 short story of the same name. It is directed by
      Mikael Håfström and stars John Cusack, Samuel L. Jackson, Mary McCormack,
      Tony Shalhoub, Len Cariou, Isiah Whitlock, Jr., and Jasmine Jessica
      Anthony. The film was released in the United States on June 22, 2007,
      although July 13 (which in 2007 fell on a Friday) is mentioned as the
      release date on the website. The film follows Mike Enslin, an author who
      investigates allegedly haunted houses and rents the titular room 1408 at
      a New York City hotel. Although skeptical of the paranormal, he is soon
      trapped in the room where he experiences bizarre events. Reviews were
      mostly positive and the film was also a financial success.
    TXT
  },
  {
    title: 'Django Unchained',
    description: <<-TXT
      Django Unchained is a 2012 American revisionist Western film written and
      directed by Quentin Tarantino, starring Jamie Foxx, Christoph Waltz,
      Leonardo DiCaprio, Kerry Washington, and Samuel L. Jackson, with Walton
      Goggins, Dennis Christopher, James Remar, and Don Johnson in supporting
      roles. Set in the Old West and Antebellum South, it is a highly stylized
      tribute to Spaghetti Westerns, in particular the 1966 Italian film Django
      by Sergio Corbucci, whose star Franco Nero has a cameo appearance.
      Development of Django Unchained began in 2007 when Tarantino was writing
      a book on Corbucci. By April 2011, Tarantino sent his final draft of the
      script to The Weinstein Company. Casting began in the summer of 2011,
      with Michael K. Williams and Will Smith being considered for the role of
      the title character before Foxx was cast. Principal photography took
      place from November 2011 to March 2012 in California, Wyoming and
      Louisiana.
    TXT
  },
  {
    title: 'Blade Runner 2049',
    description: <<-TXT
      Blade Runner 2049 is a 2017 American neo-noir science fiction film directed
      by Denis Villeneuve and written by Hampton Fancher and Michael Green.
      A sequel to the 1982 film Blade Runner, the film stars Ryan Gosling and
      Harrison Ford, with Ana de Armas, Sylvia Hoeks, Robin Wright, Mackenzie
      Davis, Carla Juri, Lennie James, Dave Bautista, and Jared Leto in
      supporting roles. Ford and Edward James Olmos reprise their roles from
      the original film. Set thirty years after the first film, Gosling plays K,
      a blade runner who uncovers a secret that threatens to instigate a war
      between humans and replicants.
    TXT
  },
  {
    title: 'Whiplash',
    description: <<-TXT
      Whiplash is a 2014 American drama film written and directed by Damien
      Chazelle. It depicts the relationship between an ambitious jazz student
      (Miles Teller) and an abusive instructor (J. K. Simmons). Paul Reiser
      and Melissa Benoist co-star. Whiplash premiered in competition in the US
      Dramatic Category at the 2014 Sundance Film Festival on January 16, 2014,
      as the festival's opening film.[3] Sony Pictures Worldwide acquired the
      international distribution rights.[4] The film opened in limited release
      domestically in the United States and Canada on October 10, 2014,
      gradually expanding to over 500 screens and finally closing on March 26,
      2015. Over this time the film grossed $49 million, against a production
      budget of $3.3 million. The film received widespread critical acclaim,
      with particular praise for Simmons's performance and Chazelle's
      screenplay. At the 87th Academy Awards, Whiplash won Best Film Editing,
      Best Sound Mixing, and Best Supporting Actor for Simmons, and was also
      nominated for Best Adapted Screenplay and Best Picture.
    TXT
  }
]

movies.each do |movie|
  Movie.create(title: movie[:title], description: movie[:description])
end

# Create categories
%w(Comedy Action Drama Horror).each do |title|
  Category.create(title: title)
end
